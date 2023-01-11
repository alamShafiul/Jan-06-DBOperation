//
//  SignUpVC.swift
//  Jan-06-DBOperations
//
//  Created by Admin on 9/1/23.
//

import UIKit

class SignUpVC: UIViewController {

//MARK: - Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//MARK: - Button Actions
    @IBAction func signupBtnClicked(_ sender: Any) {
        if let name = nameField.text, let email = emailField.text, let pass = passwordField.text {
            if let _ = KeyChain.shared.readFromKeyChain(email: email, service: "password") {
                print("invalid email")
            }
            else {
                KeyChain.shared.writeToKeyChain(email: email, service: "password", data: pass)
                KeyChain.shared.writeToKeyChain(email: email, service: "name", data: name)
                performSegue(withIdentifier: Constants.gotoLoginSegue, sender: nil)
            }
        }
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: Constants.gotoLoginSegue, sender: nil)
    }
}
