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

class TwitterSearchTimelineTableController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    @IBOutlet weak var timelineTable: UITableView!
    var client: OAuthClient!
    var streamTweets: [StreamTweets] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).streamTweets
    }
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        print("TwitterSearchTimelineTableController viewDidLoad Called")
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        print("TwitterSearchTimelineTableController viewDidAppear Called")
        super.viewDidAppear(animated)
        timelineTable.delegate = self
        timelineTable.dataSource = self
        fetchStreamTweets()
    }
    
    // MARK: Streaming
    private func fetchStreamTweets() {
        print("fetchStreamTweets Called")
        let _ = client.streaming("https://userstream.twitter.com/1.1/user.json", parameters: ["track":"LOOL1234"]).progress { (data) in
            
            // Retrieve data
            let parsedResult = JSON(data: data)
            guard let text = parsedResult["text"].string else {
                print("Cannot find key 'text' in \(parsedResult)")
                return
            }
                        
            // Add it to the streamTweets array in the Application Delegate
            let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate
            appDelegate.streamTweets.append(StreamTweets(text: text))
            print("Tweets saved, streamTweets count:" + " \(appDelegate.streamTweets.count)")
            print("Tweet: \(appDelegate.streamTweets.last!)")
            
            self.timelineTable.reloadData()
            
        }.completion { (responseData, response, error) in
            guard error == nil else {
                print(error)
                return
            }
        }.start()
    }
    
    // MARK: Table View
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streamTweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = timelineTable.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TwitterTweetViewCell
        print("YEAH!")
        let tweet = self.streamTweets[indexPath.row]
        if streamTweets.count > 0 {
            cell.tweet?.text = "\(tweet.text)"
            cell.tweet.sizeToFit()
        }
        return cell
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
