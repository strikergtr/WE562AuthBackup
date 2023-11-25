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
    
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectDB()
    }
    func connectDB()
    {
        let doc = db.collection("shop").document(uid)
        DispatchQueue.main.async {
            doc.getDocument{(document, error) in
                if let document = document, document.exists
                {
                    let itemNameData = document.get("name") as! String
                    let itemNamePriceData = (document.get("price") as? NSNumber)?.floatValue ?? 0
                    var itemImageData = "noimage"
                    if let img = document.get("image")
                    {
                        itemImageData = img as! String
                    }
                    
                    
                    self.itemName.text = String(itemNameData)
                    self.itemImage.image = UIImage(named: itemImageData)
                    self.itemPrice.text = String(itemNamePriceData)
                }
                else
                {
                    self.itemName.text = "No Item"
                    self.itemPrice.text = "Error"
                    self.itemImage.image = UIImage(named: "noimage")
                }
            }
        }
    }
    
}

class ShopController: UIViewController {

    //Outlet
    @IBOutlet weak var mytable: UITableView!
    var myitems = ["Item1","Item2","Item3","Item4","Item5"]
    
    var itemArray = [NShop]()
    
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectDB()
        mytable.delegate = self
        mytable.dataSource = self
    }
    func connectDB()
    {
        db.collection("shop").getDocuments {(snapshot, error) in
            if error == nil && snapshot != nil
            {
                for document in snapshot!.documents
                {
                    let itemID = document.documentID
                    // Map Data
                    let itemNameData = document.get("name") as! String
                    //let itemPriceData = document.get("price") as! Float
                    let itemPriceData = (document.get("price") as? NSNumber)?.floatValue ?? 0
                    
                    
                    var itemImageData = "noimage" // no image file name
                    if var img = document.get("image")
                    {
                        itemImageData = img as! String
                    }
                    
                    
                    self.itemArray.append(NShop(itemID: itemID, itemName: itemNameData, itemImage: itemImageData, itemPrice: itemPriceData, itemColor: ""))
                    // Add Firebase to Array
                    DispatchQueue.main.async {
                        self.mytable.reloadData()
                    }
                    
                }
            }
        }
    }
}
extension ShopController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Row is Click : \(indexPath[1])")
        var cellData:NShop = itemArray[indexPath[1]]
        //Add Navigation
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "ShopDetailView") as! ShopDetailController
        storyboard.uid = cellData.itemID
        
        
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}
extension ShopController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NShopCell
        
        if let nItem = itemArray[indexPath.row] as NShop?
        {
            cell.itemName.text = String(nItem.itemName)
            cell.itemImage.image = UIImage(named: nItem.itemImage)
            cell.itemPrice.text = String(nItem.itemPrice)
        }
        
        //cell.itemName.text = myitems[indexPath.row]
        //cell.itemPrice.text = "500.00"
        //cell.itemImage.image = UIImage(named: "iphone")
        //cell.textLabel?.text = myitems[indexPath.row]
        return cell
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


