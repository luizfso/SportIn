//
//  FeedWebPageViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/24/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//

import UIKit

class FeedWebPageViewController: UIViewController {
    
    var feedURL = ""
    
    @IBOutlet var myWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.loadRequest(NSURLRequest(URL: NSURL(string: feedURL)!))
        
        // Do any additional setup after loading the view.
        
        // codigo para personalizar o navigationBar
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
