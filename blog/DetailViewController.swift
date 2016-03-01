//
//  DetailViewController.swift
//  blog
//
//  Created by Leo on 3/1/16.
//  Copyright © 2016 Leo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var detail: UIWebView!
    
    var passage:Passage = Passage()
    let detailUrl = Global.server + Global.passageURL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detail.delegate = self;
        
        let url = NSURL (string: "\(detailUrl)?id=\(passage.id!)");
        
        NSLog("Requesting \(url)")
        let requestObj = NSURLRequest(URL: url!);
        detail.loadRequest(requestObj);
    }
    
}
