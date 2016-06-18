//
//  ViewController.swift
//  The Little Bird
//
//  Created by Chin-Chwen Tien on 6/17/16.
//  Copyright © 2016 CHIN-CHWEN TIEN. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterLoginViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var debugTextLabel: UILabel!
    @IBOutlet weak var loginButton: BorderedButton!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        print("TwitterLoginViewController viewDidLoad Called")
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        print("TwitterLoginViewController viewDidAppear Called")
        super.viewWillAppear(animated)
        
        debugTextLabel.text = ""
        let session = Twitter.sharedInstance().sessionStore.session() as TWTRAuthSession?
        if session != nil {
            completeLogin()
        }
    }
    
    // MARK: Action
    @IBAction func loginPressed(sender: AnyObject) {
        print("login Pressed")
        Twitter.sharedInstance().logInWithCompletion { session, error in
            if session != nil {
                print("signed in as \(session!.userName)")
            } else {
                print("error: \(error!.localizedDescription)")
            }
        }
    }
    
    // MARK: Login
    private func completeLogin() {
        debugTextLabel.text = ""
        let controller = storyboard!.instantiateViewControllerWithIdentifier("TwitterTabBarController") as! UITabBarController
        presentViewController(controller, animated: true, completion: nil)
    }
    
}

