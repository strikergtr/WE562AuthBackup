//
//  ViewController.swift
//  Authentication
//
//  Created by Instructor on 7/10/2566 BE.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func RegisterPressed(_ sender: UIButton) {
        
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "RegisterView") as! RegisterController
        
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
}

class RegisterController: UIViewController {
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func RegisterPressed(_ sender: UIButton) {
        print("Register is Pressed")
    }
    
}

class PopupController: UIViewController {
    
    @IBOutlet weak var msgtext: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        msgtext.text = "Hello"
        // Do any additional setup after loading the view.
    }
}
