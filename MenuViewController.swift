//
//  MenuViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/23/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//

import UIKit
import Parse

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    
    var menuItems:[String] = ["Home","Meu Perfil","Conexoes","Calendario","Configuracoes","Sobre","Parceiros","Sign out"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        //Circular Image
        userProfilePicture.layer.cornerRadius = userProfilePicture.frame.size.width/2
        userProfilePicture.clipsToBounds = true
        userProfilePicture.layer.borderWidth = 1
        userProfilePicture.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        loadUserDetails()
         
        
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var myCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! UITableViewCell
        
        myCell.textLabel?.text = menuItems[indexPath.row]
        
        return myCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        switch(indexPath.row)
        {
        case 0:
            // open Home page
            
            var homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
            
            var homePageNav = UINavigationController(rootViewController: homeViewController)
            
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = homePageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
            
            break
            
        case 1:
            // open "Meu Perfil"
            
            var myProfileViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MyProfileViewController") as! MyProfileViewController
            
            var myProfilePageNav = UINavigationController(rootViewController: myProfileViewController)
            
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = myProfilePageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
            
        case 2:
            // open "Conexoes"
            
            var conexoesViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ConexoesViewController") as! ConexoesViewController
            
            var conexoesPageNav = UINavigationController(rootViewController: conexoesViewController)
            
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = conexoesPageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
       
        case 3:
            // open "Calendario"
            
            var calendarViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CalendarViewController") as! CalendarViewController
            
            var calendarPageNav = UINavigationController(rootViewController: calendarViewController)
            
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = calendarPageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break

        case 4:
            // open "Configuracoes"
            
            var settingsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
            
            var settingsPageNav = UINavigationController(rootViewController: settingsViewController)
            
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = settingsPageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
     
        case 5:
            // open "Sobre"
            
            var aboutViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
            
            var aboutPageNav = UINavigationController(rootViewController: aboutViewController)
            
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = aboutPageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
    
        case 6:
            // open "Parceiros"
            
            var partnersViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PartnersViewController") as! PartnersViewController
            
            var partnersPageNav = UINavigationController(rootViewController: partnersViewController)
            
            
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = partnersPageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break

            
        case 7:
            // perform sign out and take user to sign in page
            
            
            NSUserDefaults.standardUserDefaults().removeObjectForKey("user_name")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            
            let spiningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            spiningActivity.labelText = "Sending"
            spiningActivity.detailsLabelText = "Please wait"
            
            
            PFUser.logOutInBackgroundWithBlock { (error:NSError?) -> Void in
                
                
                spiningActivity.hide(true)
                
                
                // Navigate to Protected page
                let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                
                var loginPage:LoginViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                
                var loginPageNav = UINavigationController(rootViewController:loginPage)
                
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = loginPageNav
                
                
            }
            
            
            
            break
            
        default:
            println("Option is not handled")
            
        }
        
    }
    @IBAction func editProfileButton(sender: AnyObject) {
        var editProfile = self.storyboard?.instantiateViewControllerWithIdentifier("EditProfileViewController") as! EditProfileViewController
        editProfile.opener = self
        
        let editProfileNav = UINavigationController(rootViewController: editProfile)
        
        self.presentViewController(editProfileNav, animated: true, completion: nil)
    }
    
    func loadUserDetails() {
        
        let userType = PFUser.currentUser()?.objectForKey("profile_type") as! String
        
        if (userType == "Jogador"){
            let userFirstName = PFUser.currentUser()?.objectForKey("first_name") as! String
            let userLastName = PFUser.currentUser()?.objectForKey("last_name") as! String
            
            userFullNameLabel.text = userFirstName + " " + userLastName
            
            let profilePictureObject = PFUser.currentUser()?.objectForKey("profile_picture") as! PFFile
            
            profilePictureObject.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                if(imageData != nil)
                {
                    self.userProfilePicture.image = UIImage(data: imageData!)
                }
                
            }
            
            }
        
    
        if (userType == "Empresario"){
            
            var query = PFQuery(className:"User")
            //query.whereKey("first_name", equalTo:"Sean Plott")
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    // The find succeeded.
                    println("Successfully retrieved \(objects!.count) scores.")
                    // Do something with the found objects
                    if let objects = objects as? [PFObject] {
                        for object in objects {
                            println(object.objectId)
                        }
                    }
                } else {
                    // Log details of the failure
                    println("Error: \(error!) \(error!.userInfo!)")
                }
            }
    
        /*var query = PFQuery(className: "Empresario")
            let userFirstName:String? = PFObject["first_name"] as? String
            let userLastName:String? = PFObject()["last_name"] as? String
    
        userFullNameLabel.text = userFirstName! + " " + userLastName!
    
        let profilePictureObject = PFUser.currentUser()?.objectForKey("profile_picture") as! PFFile
    
        profilePictureObject.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
    
        if(imageData != nil)
        {
        self.userProfilePicture.image = UIImage(data: imageData!)
        }
        }*/
    
   
    
      }
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
