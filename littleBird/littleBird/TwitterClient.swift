//
//  TwitterClient.swift
//  littleBird
//
//  Created by Chin-Chwen Tien on 6/16/16.
//  Copyright © 2016 CHIN-CHWEN TIEN. All rights reserved.
//

import Foundation

// MARK: TwitterClient: NSObject

class TwitterClient: NSObject {
    
    // MARK: Properties
    // shared session
    var session = NSURLSession.sharedSession()
    
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
}