//
//  TwitterConstants.swift
//  The Little Bird
//
//  Created by Chin-Chwen Tien on 6/17/16.
//  Copyright © 2016 CHIN-CHWEN TIEN. All rights reserved.
//

// MARK: TwitterClient (Constants)

extension TwitterClient {
    
    // MARK: Constants
    struct Constants {
        
        // MARK: Consumer Key
        static let ConsumerKey = "Bmctm0QNkR9QmcGNZRbUsemYv"
        static let ConsumerSecret = "UkS9IP7pXw7rrTLI9nrHV3p3vLASK6pwwHhDt6GPyGpnk3ys7H"
        
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "api.twitter.com"
        static let ApiPath = "1.1"
        static let ApiOAuthPath = "oauth"
        static let SignInWithTwitterURL: String = "https://api.twitter.com/oauth/authenticate/"
    }
    
    // MARK: Methods
    struct Methods {
        
        // MARK: Authentication
        static let RequestToken = "/request_token"
    }
    
    // MARK: 7 Parameter Keys
    struct ParameterKeys {
        static let ConsumerKey = "oauth_consumer_key"
        static let Nonce = "oauth_nonce"
        static let Signature = "oauth_signature"
        static let SignatureMethod = "oauth_signature_method"
        static let Timestamp = "oauth_timestamp"
        static let Token = "oauth_token"
        static let Version = "oauth_version"
    }
    
    // MARK: Response Keys
    struct ResponseKeys {
        static let OAuthToken = "oauth_token"
    }
}