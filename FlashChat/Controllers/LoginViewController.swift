//
//  LoginViewController.swift
//  FlashChat
//
//  Created by admin on 19.04.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print(error)
                } else {
                    self.performSegue(withIdentifier: Constans.loginSegue, sender: self)
                }
            }
        }
    }
}
