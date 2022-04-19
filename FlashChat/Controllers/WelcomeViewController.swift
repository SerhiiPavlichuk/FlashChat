//
//  WelcomeViewController.swift
//  FlashChat
//
//  Created by admin on 19.04.2022.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: CLTypingLabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "⚡️FlashChat"

    }
}

