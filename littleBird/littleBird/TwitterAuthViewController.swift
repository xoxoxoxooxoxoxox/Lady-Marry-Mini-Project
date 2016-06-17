//
//  TwitterAuthViewController.swift
//  littleBird
//
//  Created by Chin-Chwen Tien on 6/16/16.
//  Copyright © 2016 CHIN-CHWEN TIEN. All rights reserved.
//

import UIKit

class TwitterAuthViewController: UIViewController {
    
    // MARK: Properties
    var urlRequest: NSURLRequest? = nil
    var completionHandlerForView: ((success: Bool, errorString: String?) -> Void)? = nil
    
    // MARK: Outlets
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        print("TwitterAuthViewController viewDidLoad Called")
        super.viewDidLoad()
        navigationItem.title = "Authentication"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancelAuth))
    }
    
    override func viewWillAppear(animated: Bool) {
        print("TwitterAuthViewController viewDidAppear Called")
        super.viewWillAppear(animated)
        
        if let urlRequest = urlRequest {
            webView.loadRequest(urlRequest)
        }
    }
    
    // MARK: Cancel Auth Flow
    func cancelAuth() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: - TwitterAuthViewController: UIWebViewDelegate

extension TwitterAuthViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        if webView.request!.URL!.absoluteString == "https://api.twitter.com/oauth2/token" {
            
            dismissViewControllerAnimated(true) {
                self.completionHandlerForView!(success: true, errorString: nil)
            }
        }
    }
}