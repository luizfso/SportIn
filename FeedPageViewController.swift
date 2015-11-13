//
//  FeedPageViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/24/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//

import UIKit

class FeedPageViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    @IBOutlet weak var myWebView: UIWebView!
    
    var selectedFeedTitle = String()
    var selectedFeedFeedContent = String()
    var selectedFeedURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // codigo para personalizar o navigationBar
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        // Do any additional setup after loading the view, typically from a nib.
        let feedContent:String! = "<h3>\(selectedFeedTitle)</h3>\(selectedFeedFeedContent)"
        myWebView.loadHTMLString(feedContent, baseURL: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "openWebPage" {
            
            let fwpvc: FeedWebPageViewController = segue.destinationViewController as! FeedWebPageViewController
            selectedFeedURL =  selectedFeedURL.stringByReplacingOccurrencesOfString(" ", withString:"")
            selectedFeedURL =  selectedFeedURL.stringByReplacingOccurrencesOfString("\n", withString:"")
            fwpvc.feedURL = selectedFeedURL
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
