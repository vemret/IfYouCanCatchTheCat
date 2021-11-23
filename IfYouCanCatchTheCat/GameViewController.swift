//
//  GameViewController.swift
//  IfYouCanCatchTheCat
//
//  Created by Vahit Emre TELLİER on 18.11.2021.
//

import UIKit

class GameViewController: UIViewController {
    
    var timer = Timer()
    var counter:Int = 10
    var incomingData:String = ""
    var score:Int = 0
    var highScore: Int = 0
    var catArray = [UIImageView]()
    var imgHideTimer = Timer()
    
    @IBOutlet weak var incomingDataLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
   
    @IBOutlet weak var catImg1: UIImageView!
    @IBOutlet weak var catImg2: UIImageView!
    @IBOutlet weak var catImg3: UIImageView!
    @IBOutlet weak var catImg4: UIImageView!
    @IBOutlet weak var catImg5: UIImageView!
    @IBOutlet weak var catImg6: UIImageView!
    @IBOutlet weak var catImg7: UIImageView!
    @IBOutlet weak var catImg8: UIImageView!
    @IBOutlet weak var catImg9: UIImageView!
    
//    var imgArray[9] = new Array[] as [UIImageView]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = "\(counter)"
        incomingDataLabel.text = incomingData
        
        let storedHighScore =  UserDefaults.standard.object(forKey: "highScore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        
//        for Time
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        imgHideTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(hideCat), userInfo: nil, repeats: true)

        catImg1.isUserInteractionEnabled = true
        catImg2.isUserInteractionEnabled = true
        catImg3.isUserInteractionEnabled = true
        catImg4.isUserInteractionEnabled = true
        catImg5.isUserInteractionEnabled = true
        catImg6.isUserInteractionEnabled = true
        catImg7.isUserInteractionEnabled = true
        catImg8.isUserInteractionEnabled = true
        catImg9.isUserInteractionEnabled = true

        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(getScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(getScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(getScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(getScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(getScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(getScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(getScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(getScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(getScore))

        catImg1.addGestureRecognizer(gestureRecognizer1)
        catImg2.addGestureRecognizer(gestureRecognizer2)
        catImg3.addGestureRecognizer(gestureRecognizer3)
        catImg4.addGestureRecognizer(gestureRecognizer4)
        catImg5.addGestureRecognizer(gestureRecognizer5)
        catImg6.addGestureRecognizer(gestureRecognizer6)
        catImg7.addGestureRecognizer(gestureRecognizer7)
        catImg8.addGestureRecognizer(gestureRecognizer8)
        catImg9.addGestureRecognizer(gestureRecognizer9)
        
        catArray = [catImg1,catImg2,catImg3,catImg4,catImg5,catImg6,catImg7,catImg8,catImg9]
        hideCat()
        

    }
    
    
    @objc func hideCat(){
        for cat in catArray{
            cat.isHidden = true
        }
        let randomNum = Int(arc4random_uniform(UInt32(catArray.count)))
        catArray[randomNum].isHidden = false
    }
    
    @objc func getScore(){
        print("tıklandı")
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func timerFunc(){
        timeLabel.text = "\(counter)"
        counter -= 1
        if(counter<=0){
            timer.invalidate()
            imgHideTimer.invalidate()
            timeLabel.text = "Time is Over!"
            makeAlert(titleInput: "Game is Over!", messageInput: "Time is Over. Your Score is \(score)")
            for cat in catArray{
                cat.isHidden = true
            }
            
            if self.score > self.highScore {
                self.highScore = self.score
                
                self.highScoreLabel.text = "High Score: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
            }
            
        }
        //        for gesture Recognize
    }
    
    
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
            
//            replat function
            self.score = 0;
            self.scoreLabel.text = "Score: \(self.score)"
            self.counter = 10
            self.timeLabel.text = String(self.counter)
            
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)
            self.imgHideTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(self.hideCat), userInfo: nil, repeats: true)
            }
        alert.addAction(okButton)
        alert.addAction(replayButton)
        self.present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
