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
    
    // MARK: Shared Instance
    class func sharedInstance() -> TwitterClient {
        struct Singleton {
            static var sharedInstance = TwitterClient()
        }
        return Singleton.sharedInstance
    }
    
    // MARK: POST
    func taskForPOSTMethod(method: String, parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOST: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* 1. Set the parameters */
        var parametersWithApiKey = parameters
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(URL: TwitterURLFromParameters(parametersWithApiKey, withPathExtension: method))
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = jsonBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        /* 4. Make the request */
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(result: nil, error: NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
//            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPOST)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
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