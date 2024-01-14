//
//  ViewController.swift
//  Authentication
//
//  Created by Instructor on 7/10/2566 BE.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore //<--- Import Firestore

class ViewController: UIViewController {
    
    //Outlet
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(Auth.auth().currentUser != nil)
        {
            print("Have User")
            let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as! MainTabbarController
            self.navigationController?.pushViewController(storyboard, animated: true)
        }
        else
        {
            print("No User")
        }
        // Do any additional setup after loading the view.
    }
    //Action Zone
    
    @IBAction func LoginPressed(_ sender: UIButton) {
        print("Press");
        let manager = FirebaseManager()
        if let email = email.text, let password = password.text {
            manager.login(email: email, password: password) {[weak self] (success) in
                guard let `self` = self else {return}
                var message: String = ""
                if(success) {
                    print ("Login Success")
                    print (Auth.auth().currentUser?.email)
                    let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as! UITabBarController
                    self.navigationController?.pushViewController(storyboard, animated: true)
                    
                    
                    
                    
                    
                } else {
                    print ("Login Failed")
                }
            }
        }
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
        let manager = FirebaseManager()
        if let email = Username.text, let password = Password.text {
            manager.register(email: email, password: password) {[weak self] (success) in
                guard let `self` = self else {return}
                var message: String = ""
                if(success){
                    message = "User was successfully created."
                } else {
                    message = "Error Try Again."
                }
                let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "PopupView") as! PopupController
                storyboard.msg = message
                self.present(storyboard, animated: true)
            }
          }
        }
    }



class PopupController: UIViewController {
    
    @IBOutlet weak var msgtext: UILabel!
    var msg: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        msgtext.text = msg
        // Do any additional setup after loading the view.
    }
}



class ShopDetailController:  UIViewController
{
    //Outlet
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemName: UILabel!
    
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var itemDesc: UILabel!
    
    var uid:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

class TestController:  UIViewController
{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

class ShopController: UIViewController {


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func ClicktoChangePage(_ sender: UIButton) {
        print("OK")
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "ShopDetailView") as! ShopDetailController
        
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
}





class ItemController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

class CartController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

class MainTabbarController : UITabBarController {
    
}


