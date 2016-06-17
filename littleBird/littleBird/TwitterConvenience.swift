//
//  TwitterConvenience.swift
//  littleBird
//
//  Created by Chin-Chwen Tien on 6/16/16.
//  Copyright © 2016 CHIN-CHWEN TIEN. All rights reserved.
//

import UIKit
import Foundation

// MARK: TwitterClient (Convenient Resource Methods)

extension TwitterClient {
    
    func authenticateViaMobileSign(hostViewController: UIViewController, completionHandlerForAuth: (success: Bool, errorString: String?) -> Void) {
        print("authenticateViaMobileSign Called")
        let authorizationURL = NSURL(string: "\(TwitterClient.Constants.SignInWithTwitterURL)")
        let request = NSURLRequest(URL: authorizationURL!)
        let webAuthViewController = hostViewController.storyboard!.instantiateViewControllerWithIdentifier("TwitterAuthViewController") as! TwitterAuthViewController
        webAuthViewController.urlRequest = request
        
        let webAuthNavigationController = UINavigationController()
        webAuthNavigationController.pushViewController(webAuthViewController, animated: false)
        hostViewController.presentViewController(webAuthNavigationController, animated: true, completion: nil)
    }
}