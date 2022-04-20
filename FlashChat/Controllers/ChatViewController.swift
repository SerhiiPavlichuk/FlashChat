//
//  ChatViewController.swift
//  FlashChat
//
//  Created by admin on 19.04.2022.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constans.appName
        navigationItem.hidesBackButton = true

    }

    @IBAction func sendMessageButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }

    }
}
