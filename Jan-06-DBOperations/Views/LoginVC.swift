//
//  LoginVC.swift
//  Jan-06-DBOperations
//
//  Created by Admin on 9/1/23.
//

import UIKit

class LoginVC: UIViewController {

//MARK: - Variables
    let plistKey = "plistKey"
    
//MARK: - Outlets
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        if let getData = PList.shared.readFromPlist() {
            emailField.text = getData[plistKey]!.first
            passwordField.text = getData[plistKey]!.last
        }
    }
    
//MARK: - Button Actions
    @IBAction func loginBtnClicked(_ sender: Any) {
        if let email = emailField.text, let pass = passwordField.text {
            if let fetchPass = KeyChain.shared.readFromKeyChain(email: email, service: "password") {
                print("fetchPass: \(fetchPass), pass: \(pass)")
                if(fetchPass == pass) {
                    PList.shared.writeToPlist(dict: [plistKey: [emailField.text!, passwordField.text!]])
                    performSegue(withIdentifier: Constants.gotoHomeSegue, sender: nil)
                }
                else {
                    print("invalid password.")
                }
            }
            else {
                print("INVALID PASSWORD")
            }
        }
//        if(emailField?.text == "a" && passwordField.text == "b") {
//            PList.shared.writeToPlist(dict: [plistKey: [emailField.text!, passwordField.text!]])
//            //guard let data = try? JSONEncoder().encode(passwordField.text!) else { return }
//            //writeToKeyChain(data: data, email: emailField.text!)
//            performSegue(withIdentifier: Constants.gotoHomeSegue, sender: nil)
//        }
    }
}
