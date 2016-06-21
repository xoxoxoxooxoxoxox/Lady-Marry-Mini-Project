//
//  TwitterTimelineTableController.swift
//  The Little Bird
//
//  Created by Chin-Chwen Tien on 6/18/16.
//  Copyright © 2016 CHIN-CHWEN TIEN. All rights reserved.
//

import UIKit
import TwitterKit
import STTwitter
import OAuthSwift

class TwitterSearchTimelineTableController: UIViewController {
    
    // MARK: Properties
    var oauthSwift: OAuth1Swift!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        print("TwitterSearchTimelineTableController viewDidLoad Called")
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        print("TwitterSearchTimelineTableController viewDidAppear Called")
        super.viewDidAppear(animated)
        fetchStreamTweets()
    }
    
    // MARK: Streaming
    private func fetchStreamTweets() {
        print("fetchStreamTweets Called")
        let url = "https://userstream.twitter.com/1.1/user.json"
        oauthSwift.client.get(url, parameters: ["track": "NBA"], success: { (data, response) in
            let jsonDict: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
            print(jsonDict)
            }) { (error) in
                print(error)
        }
    }
    
    // MARK: Sign out
    @IBAction func signOut(sender: AnyObject) {
        // Remove any Twitter or Digits local sessions for this app.
        let sessionStore = Twitter.sharedInstance().sessionStore
        if let userId = sessionStore.session()?.userID {
            sessionStore.logOutUserID(userId)
        }
        // Present the sign in again
        dismissViewControllerAnimated(true, completion: nil)
    }
}
