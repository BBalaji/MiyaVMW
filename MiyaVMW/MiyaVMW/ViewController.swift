//
//  ViewController.swift
//  MiyaVMW
//
//  Created by Besta, Balaji (623-Extern) on 28/08/20.
//  Copyright © 2020 Balaji Besta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var currentParsingElement : String!
    
    var cus_no : String = ""
    var cus_name : String = ""
    var addr_1 : String = ""
    var email : String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//        emailTextField.delegate = self as? UITextFieldDelegate
//        passwordTextField.delegate = self as? UITextFieldDelegate
        
        
        UITextField.connectFields(fields: [emailTextField, passwordTextField])
        let iconWidth = 20;
        let iconHeight = 20;
        
        //Define the imageView
        let imageView = UIImageView();
        let imageEmail = UIImage(named: "Icon feather-user");
        imageView.image = imageEmail;
        
        // set frame on image before adding it to the uitextfield
        imageView.frame = CGRect(x: 11, y: 13, width: iconWidth, height: iconHeight)
        emailTextField.leftViewMode = UITextField.ViewMode.always
        emailTextField.addSubview(imageView)

        let imageViewPassword = UIImageView();
        let imagePassword = UIImage(named: "privacy");
        
        // set frame on image before adding it to the uitextfield
        imageViewPassword.image = imagePassword;
        imageViewPassword.frame = CGRect(x: 11, y: 13, width: iconWidth, height: iconHeight)
        passwordTextField.leftViewMode = UITextField.ViewMode.always
        passwordTextField.addSubview(imageViewPassword)
        
        
       /* //Show hide password
        let imageViewShowHidePassword = UIImageView();
        let imageShowHidePassword = UIImage(named: "Icon feather-eye");
        
        // set frame on image before adding it to the uitextfield
        imageViewShowHidePassword.image = imageShowHidePassword;
        imageViewShowHidePassword.frame = CGRect(x: 11, y: 100, width: iconWidth, height: iconHeight)
        passwordTextField.leftViewMode = UITextField.ViewMode.always
        passwordTextField.addSubview(imageViewPassword)*/
        
        let rightButton  = UIButton(type: .custom)
        rightButton.frame = CGRect(x:0, y:0, width:30, height:30)
        let securePaddingView = UIView.init(frame: CGRect(x: 0, y: 0, width: 50 , height: 30))
        
        passwordTextField.rightView = securePaddingView
        
        passwordTextField.rightView = rightButton
        
        rightButton.setImage(UIImage(named: "Icon feather-eye") , for: .normal)
        rightButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
        passwordTextField.rightViewMode = .always
        
        
        
        //set Padding
        let paddingView = UIView.init(frame: CGRect(x: 0, y: 0, width: 35, height: self.emailTextField.frame.height))
        emailTextField.leftView = paddingView
        
        let emailPaddingView = UIView.init(frame: CGRect(x: 0, y: 0, width: 35, height: self.passwordTextField.frame.height))
        passwordTextField.leftView = emailPaddingView
        
        
        
//        emailTextField.text = "abc"
//        passwordTextField.text = "avv"
//        passwordTextField.becomeFirstResponder()
    }
    
    @objc func toggleShowHide() {
        passwordTextField.isSecureTextEntry.toggle()
    }

    @IBAction func testUserAction(_ sender: Any) {
        emailTextField.text = "ZC"
        passwordTextField.text = "zyber"
        
    }
    @IBAction func clearUserAction(_ sender: Any) {
        emailTextField.text = ""
        passwordTextField.text = ""
        
    }
    @IBAction func loginAction(_ sender: Any) {
        if emailTextField.text!.isEmpty ||   passwordTextField.text!.isEmpty {
        print("Please enter both fields.")
            // create the alert
            let alert = UIAlertController(title: "Alert!", message: "Please enter both fields.", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let username  = emailTextField.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            
            let password  = passwordTextField.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            
            getXMLDataFromServer(username: (username?.uppercased())!, password: password!)
        }
        
    }
    func getXMLDataFromServer(username : String,password :String){
        let url = NSURL(string: "http://192.168.3.220:7741/zwms_dev/wmsrequest?action=User&usr=\(username)&pwd=\(password)")
         
        //Creating data task
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
             
            if data == nil {
                print("dataTaskWithRequest error: \(String(describing: error?.localizedDescription))")
                return
            }
            let parser = XMLParser(data: data!)
            parser.delegate = self
            parser.parse()
             
        }
         
        task.resume()
      
    }
    
    //Hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    
}
extension ViewController : XMLParserDelegate{
    //MARK:- XML Delegate methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentParsingElement = elementName
        if elementName == "Users" {
            print("Started parsing...")
        }
    }
      
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let foundedChar = string.trimmingCharacters(in:NSCharacterSet.whitespacesAndNewlines)
          
        if (!foundedChar.isEmpty) {
            if currentParsingElement == "cus_no" {
                cus_no += foundedChar
            }
            else if currentParsingElement == "cus_name" {
                cus_name += foundedChar
            }
            else if currentParsingElement == "addr_1" {
                addr_1 += foundedChar
            }
            else if currentParsingElement == "email" {
                email += foundedChar
            }
            
        }
          
    }
      
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Users" {
            print("Ended parsing...")
              
        }
    }
      
    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.async {
            // Update UI
            print(" self.displayOnUI()")
            print("data  :: ",self.cus_no,self.cus_name,self.addr_1,self.email)
            
            if self.cus_no.isEmpty{
                print("no response")
                
                // create the alert
                let alert = UIAlertController(title: "Alert!", message: "This user is not valid.", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
                
            }else {
            
//            let VC1 : UserInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "userInfoVC") as! UserInfoVC
                
//                let VC1 : DetailMainVC = self.storyboard?.instantiateViewController(withIdentifier: "detailMainVC") as! DetailMainVC
//
//
//            Singleton.shared.cusno = self.cus_no
//            Singleton.shared.cusname = self.cus_name
//            Singleton.shared.add1 = self.addr_1
//            Singleton.shared.email = self.email
//
//            self.cus_no = ""
//            self.cus_name = ""
//            self.addr_1 = ""
//            self.email = ""
//
//                self.emailTextField.text = ""
//                self.passwordTextField.text = ""
//
//            self.present(VC1, animated: true, completion: nil)
                
                let VC:DetailMainVC = self.storyboard?.instantiateViewController(withIdentifier: "detailMainVC") as! DetailMainVC
                Singleton.shared.cusno = self.cus_no
                Singleton.shared.cusname = self.cus_name
                Singleton.shared.add1 = self.addr_1
                Singleton.shared.email = self.email

                self.cus_no = ""
                self.cus_name = ""
                self.addr_1 = ""
                self.email = ""

                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                
                
                self.navigationController?.pushViewController(VC, animated: true)
            }
            
            
            
        }
    }
      
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
}

private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
               return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
    

    @objc func fix(textField: UITextField) {
        if let t: String = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
}

struct userInfo : Codable {
    var cusno : String
    var cusname : String
    var add1 : String
    var email : String
    
//    init(cusnotemp : String,cusnametemp : String,add1temp : String,emailtemp : String ) {
//        cusno = cusnotemp
//        cusname = cusnotemp
//        add1 = add1temp
//        email = emailtemp
//    }
}
class Singleton {
    static let shared = Singleton()

    var cusno : String!
    var cusname : String!
    var add1 : String!
    var email : String!
}
extension UITextField {
    class func connectFields(fields:[UITextField]) -> Void {
        guard let last = fields.last else {
            return
        }
        for i in 0 ..< fields.count - 1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
}
