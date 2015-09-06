//
//  HomeViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/23/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var itemView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let item1 = UIImage(named: "business-person.png")
        itemView.image = item1 as UIImage?
        //let item2 = UIImage(named: "FoxSport-logo100x100.fw.png")
        //itemView.image = item2 as UIImage?
        //let item3 = UIImage(named: "espn_logo100x100.fw.png")
        //let item4 = UIImage(named: "espn_logo100x100.fw.png")
        
        ScrollView.contentSize = CGSize(width: 3000, height: 200)
        itemView.frame = CGRect(x: 2700, y: 2, width: 100, height: 100)
        ScrollView.addSubview(itemView)
        
        // Do any additional setup after loading the view.
        
        // codigo para personalizar o navigationBar
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        //self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        let logotipo = UIImage(named: "logoSmall.png")
        let imageCenter = UIImageView(image: logotipo)
        self.navigationItem.titleView = imageCenter;
        
               
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuButton(sender: AnyObject) {
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
    }
    
    @IBAction func rssFeedButton(sender: AnyObject) {
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Right, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
