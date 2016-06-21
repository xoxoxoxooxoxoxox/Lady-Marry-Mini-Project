//
//  TwitterTimelineTableController.swift
//  The Little Bird
//
//  Created by Chin-Chwen Tien on 6/18/16.
//  Copyright © 2016 CHIN-CHWEN TIEN. All rights reserved.
//

import UIKit
import TwitterKit
import OAuthSwift
import TwitterAPI
import SwiftyJSON

class TwitterSearchTimelineTableController: UIViewController {
    
    // MARK: Properties
    var client: OAuthClient!
    
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
        let request = client.streaming("https://userstream.twitter.com/1.1/user.json", parameters: ["track":"NBA"]).progress { (data) in
            let json = JSON(data: data)
            print(json)
        }.completion { (responseData, response, error) in
            guard error == nil else {
//                print(error)
                return
            }
        }.start()
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
