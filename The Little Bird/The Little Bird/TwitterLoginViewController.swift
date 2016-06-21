//
//  ViewController.swift
//  The Little Bird
//
//  Created by Chin-Chwen Tien on 6/17/16.
//  Copyright © 2016 CHIN-CHWEN TIEN. All rights reserved.
//

import UIKit
import STTwitter
import TwitterKit
import OAuthSwift

class TwitterLoginViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var debugTextLabel: UILabel!
    @IBOutlet weak var loginButton: BorderedButton!
    let oauthswift = OAuth1Swift(
        consumerKey:    "Bmctm0QNkR9QmcGNZRbUsemYv",
        consumerSecret: "UkS9IP7pXw7rrTLI9nrHV3p3vLASK6pwwHhDt6GPyGpnk3ys7H",
        requestTokenUrl: "https://api.twitter.com/oauth/request_token",
        authorizeUrl:    "https://api.twitter.com/oauth/authorize",
        accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
    )
    
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
        print("loginButton Pressed")
        oauthswift.authorizeWithCallbackURL(
            NSURL(string: "The-Little-Bird://oauth-callback/twitter")!,
            success: { credential, response, parameters in
                print(credential.oauth_token)
                print(credential.oauth_token_secret)
                print(parameters["user_id"])
                print(parameters)
                self.completeLogin()
            },
            failure: { error in
                print(error.localizedDescription)
            }             
        )
    }
    
    // MARK: Login
    private func completeLogin() {
        self.performSegueWithIdentifier("SignInCompleted", sender: self)
    }
        
    // MARK: Pass data between 2 VCs via segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SignInCompleted" {
            if let controller = segue.destinationViewController as? TwitterSearchTimelineTableController {
                controller.oauthSwift = self.oauthswift
            }
        }
    }
    
}

