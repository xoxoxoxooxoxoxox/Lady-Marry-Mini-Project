//
//  ViewController.swift
//  test
//
//  Created by Chin-Chwen Tien on 6/19/16.
//  Copyright © 2016 CHIN-CHWEN TIEN. All rights reserved.
//

import UIKit
import STTwitter

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        print("TwitterLoginViewController viewDidLoad Called")
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        print("TwitterLoginViewController viewDidAppear Called")
        super.viewWillAppear(animated)
        
    }
    
    // MARK: Action
    @IBAction func loginPressed(sender: AnyObject) {
        print("loginButton Pressed")
        
        let twitter = STTwitterAPI(OAuthConsumerKey: "Bmctm0QNkR9QmcGNZRbUsemYv", consumerSecret: "UkS9IP7pXw7rrTLI9nrHV3p3vLASK6pwwHhDt6GPyGpnk3ys7H")
        
        print("1")
        
        twitter.postTokenRequest({ (url, oauthToken) in
            
            print("2")
//            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("TwitterAuthViewController") as! TwitterAuthViewController
//            self.presentViewController(controller, animated: true, completion: {
//                print("3")
//                let request = NSURLRequest(URL: url)
//                controller.webView.loadRequest(request)
//            })
            }, authenticateInsteadOfAuthorize: false,
               forceLogin: true,
               screenName: nil,
               oauthCallback: "myapp://twitter_access_tokens/") { (error) in
                print(error)
                
        }
        
        print("4")
    }
    

    


}

