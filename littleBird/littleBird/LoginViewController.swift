//
//  ViewController.swift
//  littleBird
//
//  Created by Chin-Chwen Tien on 6/16/16.
//  Copyright © 2016 CHIN-CHWEN TIEN. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var debugTextLabel: UILabel!
    @IBOutlet weak var loginButton: BorderedButton!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        print("LoginViewController viewDidLoad Called")
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        print("LoginViewController viewDidAppear Called")
        super.viewWillAppear(animated)
        
        debugTextLabel.text = ""
    }
    
    // MARK: Action
    @IBAction func loginPressed(sender: AnyObject) {
        print("login Pressed")
    }
    
    
    // MARK: Login


}

