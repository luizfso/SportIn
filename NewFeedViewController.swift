//
//  NewFeedViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/24/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//

import UIKit

class NewFeedViewController: UIViewController {
    
    @IBOutlet weak var textFieldNewFeedUrl: UITextField!
    
    // Reusbale member
    var onDataAvailable : ((data: NSURL) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // codigo para personalizar o navigationBar
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    @IBAction func boneButton(sender: AnyObject) {
        
        // Send new Url
        if (textFieldNewFeedUrl.text != "") {
            self.onDataAvailable?(data: NSURL(string: textFieldNewFeedUrl.text)!)
            self.navigationController?.popToRootViewControllerAnimated(true)
        } else {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    @IBAction func sFeedGlobo(sender: AnyObject) {
        textFieldNewFeedUrl.text = "http://globoesporte.globo.com/servico/semantica/editorias/plantao/futebol/campeonatos-estaduais/campeonato-paulista/feed.rss"
    }
    
    @IBAction func sFeedBBC(sender: AnyObject) {
         textFieldNewFeedUrl.text = "http://news.bbc.co.uk/sol/ukfs_sport/mobile/rss.xml"
    }
    
    @IBAction func sFeedFOX(sender: AnyObject) {
        textFieldNewFeedUrl.text = "http://api.foxsports.com/v1/rss?partnerKey=zBaFxRyGKCfxBagJG9b8pqLyndmvo7UU"
    }
    
    @IBAction func sFeedESPN(sender: AnyObject) {
        textFieldNewFeedUrl.text = "http://sports.espn.go.com/espn/rss/news"
    }
    
    @IBAction func sFeedCBS(sender: AnyObject) {
        textFieldNewFeedUrl.text = "http://cbssports.com/partners/feeds/rss/home_news"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
