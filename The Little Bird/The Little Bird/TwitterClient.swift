//
//  TwitterClient.swift
//  The Little Bird
//
//  Created by Chin-Chwen Tien on 6/17/16.
//  Copyright © 2016 CHIN-CHWEN TIEN. All rights reserved.
//

import Foundation

// MARK: TwitterClient: NSObject

class TwitterClient: NSObject {
    
    // MARK: Properties
    
    // shared session
    var session = NSURLSession.sharedSession()
    
    // authentication state
    var oauth_token: String? = nil
    var oauth_token_secret: String? = nil
    var screen_name: String? = nil
    var user_id: Int? = nil
    
    // MARK: Initializers
    override init() {
        super.init()
    }
    
    // MARK: Auxiliary functions
    // create a URL from parameters
    func TwitterURLFromParameters(parameters: [String:AnyObject], withPathExtension: String? = nil) -> NSURL {
        
        let components = NSURLComponents()
        components.scheme = TwitterClient.Constants.ApiScheme
        components.host = TwitterClient.Constants.ApiHost
        components.path = TwitterClient.Constants.ApiPath + (withPathExtension ?? "")
        components.queryItems = [NSURLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.URL!
    }
    
    // MARK: Shared Instance
    class func sharedInstance() -> TwitterClient {
        struct Singleton {
            static var sharedInstance = TwitterClient()
        }
        return Singleton.sharedInstance
    }
}