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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = Constans.appName
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}

