//
//  ViewController.swift
//  littleBird
//
//  Created by Chin-Chwen Tien on 6/16/16.
//  Copyright © 2016 CHIN-CHWEN TIEN. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var debugTextLabel: UILabel!
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        print("LoginViewController viewDidLoad Called")
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        print("LoginViewController viewDidAppear Called")
        super.viewWillAppear(animated)
        
        debugTextLabel.text = ""
        
        let loginButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In",
                    message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // TODO: Change where the log in button is positioned in your view
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }

}

