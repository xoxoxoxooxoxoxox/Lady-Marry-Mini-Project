//
//  ViewController.swift
//  The Little Bird
//
//  Created by Chin-Chwen Tien on 6/17/16.
//  Copyright © 2016 CHIN-CHWEN TIEN. All rights reserved.
//

import UIKit
import TwitterKit
import STTwitter

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
    }
    
    // MARK: Action
    @IBAction func loginPressed(sender: AnyObject) {
        print("login Pressed")
    }
    
    // MARK: Login
    private func completeLogin() {
        debugTextLabel.text = ""
        let controller = storyboard!.instantiateViewControllerWithIdentifier("TwitterTabBarController") as! UITabBarController
        presentViewController(controller, animated: true, completion: nil)
    }
    
}

