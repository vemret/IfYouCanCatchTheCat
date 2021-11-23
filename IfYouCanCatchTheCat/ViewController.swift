//
//  ViewController.swift
//  IfYouCanCatchTheCat
//
//  Created by Vahit Emre TELLİER on 18.11.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTexField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let storedName = UserDefaults.standard.object(forKey: "name")
        
        if let newName = storedName as? String{
            nameTexField.text = newName
        }
        
    }

    @IBAction func goClicked(_ sender: Any) {
//        sender: Karşı tarafa bilgi yollamak için
        performSegue(withIdentifier: "toGameVC", sender: nil)
        
//        veri depolamak
        UserDefaults.standard.set(nameTexField.text!, forKey: "name")
        
    }
    
//    diğer sayfaya veri aktarırken diğer değişkene ulaşılıyo
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        eğer seguenin kimliği buysa
        if segue.identifier == "toGameVC"{
            
//            sonraki sayfa tipinden segue cast ediyoruz => as
//            destinationVC ile gidilecek pencerenin sahip olduğu değişkenleri görebilcez
            let destinationVC = segue.destination as! GameViewController
            destinationVC.incomingData=nameTexField.text!
        }
    }
    
}

