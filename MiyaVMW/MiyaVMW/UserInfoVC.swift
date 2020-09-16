//
//  UserInfoVC.swift
//  MiyaVMW
//
//  Created by Besta, Balaji (623-Extern) on 31/08/20.
//  Copyright © 2020 Balaji Besta. All rights reserved.
//

import Foundation
import UIKit
class UserInfoVC: UIViewController {
    @IBOutlet var cus_no : UILabel!
    @IBOutlet var cus_name : UILabel!
    @IBOutlet var addr_1 : UILabel!
    @IBOutlet var email : UILabel!
    
//    var cus_no_Value : String!
//    var cus_name_Value : String!
//    var addr_1_Value : String!
//    var email_Value : String!
    
    var user : userInfo!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
        
        print("values : ",Singleton.shared.cusname as Any)
        let number  = Singleton.shared.cusno as String
        
        self.cus_no.text = number
        self.cus_name.text = Singleton.shared.cusname
        self.addr_1.text = Singleton.shared.add1
        self.email.text = Singleton.shared.email
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        self.cus_no.text = ""
        self.cus_name.text = ""
        self.addr_1.text = ""
        self.email.text = ""
        
        Singleton.shared.cusno = " "
        Singleton.shared.cusname = " "
        Singleton.shared.add1 = " "
        Singleton.shared.email = " "
        self.dismiss(animated: true, completion: nil)
        
    }
}
