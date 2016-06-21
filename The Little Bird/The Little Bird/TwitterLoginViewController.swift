//
//  ViewController.swift
//  The Little Bird
//
//  Created by Chin-Chwen Tien on 6/17/16.
//  Copyright © 2016 CHIN-CHWEN TIEN. All rights reserved.
//

import UIKit
import TwitterKit
import OAuthSwift
import TwitterAPI

class TwitterLoginViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var debugTextLabel: UILabel!
    @IBOutlet weak var loginButton: BorderedButton!
    var accessToken: String? = nil
    var accessTokenSecret: String? = nil
    
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
        let oauthswift = OAuth1Swift(
            consumerKey:    TwitterClient.Constants.ConsumerKey,
            consumerSecret: TwitterClient.Constants.ConsumerSecret,
            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
            accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
        )
        oauthswift.authorizeWithCallbackURL(
            NSURL(string: "The-Little-Bird://oauth-callback/twitter")!,
            success: { credential, response, parameters in
                self.accessToken = credential.oauth_token
                self.accessTokenSecret = credential.oauth_token_secret
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
                let client = OAuthClient(
                    consumerKey: TwitterClient.Constants.ConsumerKey,
                    consumerSecret: TwitterClient.Constants.ConsumerSecret,
                    accessToken: accessToken!,
                    accessTokenSecret: accessTokenSecret!)
                controller.client = client
            }
        }
    }
    
}

