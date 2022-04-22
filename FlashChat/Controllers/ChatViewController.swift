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

    let db = Firestore.firestore()

    var messages: [Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constans.appName
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: Constans.cellNibName, bundle: nil), forCellReuseIdentifier: Constans.cellIdentifier)
        loadmessages()

    }

    func loadmessages() {
        db.collection(Constans.FStore.collectionName)
            .order(by: Constans.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in

            self.messages = []

            if let error = error {
                print("Can`t load messages from base \(error)")
            } else {
                if let snapShotDocuments = querySnapshot?.documents {
                    for doc in snapShotDocuments {
                        let data = doc.data()
                        if let messageBody = data[Constans.FStore.bodyField] as? String, let messageSender = data[Constans.FStore.senderField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)

                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }

    @IBAction func sendMessageButtonPressed(_ sender: UIButton) {
        if let messageSender = Auth.auth().currentUser?.email, let messageBody = messageTextField.text {
            db.collection(Constans.FStore.collectionName).addDocument(data: [
                Constans.FStore.senderField: messageSender,
                Constans.FStore.bodyField: messageBody,
                Constans.FStore.dateField: Date().timeIntervalSince1970
            ]) { error in
                if let error = error {
                    print("There are error \(error)")
                } else {
                    print("Succes")
                    
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
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

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constans.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageView.backgroundColor = UIColor(named: Constans.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: Constans.BrandColors.purple)
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageView.backgroundColor = UIColor(named: Constans.BrandColors.purple)
            cell.label.textColor = UIColor(named: Constans.BrandColors.lightPurple)
        }

        return cell
    }
}
