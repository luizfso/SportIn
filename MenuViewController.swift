//
//  MenuViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/23/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//?

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
        //userProfilePicture.layer.cornerRadius = userProfilePicture.frame.size.width/2
        userProfilePicture.layer.cornerRadius = 40
        userProfilePicture.clipsToBounds = true
        userProfilePicture.layer.borderWidth = 1
        userProfilePicture.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        loadUserDetails()
         
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
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
        let myCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) 
        
        myCell.textLabel?.text = menuItems[indexPath.row]
        
        return myCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        switch(indexPath.row)
        {
        case 0:
            // open Home page
            
            let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
            
            let homePageNav = UINavigationController(rootViewController: homeViewController)
            
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = homePageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
            
            break
            
        case 1:
            // open "Meu Perfil"
            
            let myProfileViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MyProfileViewController") as! MyProfileViewController
            
            let myProfilePageNav = UINavigationController(rootViewController: myProfileViewController)
            
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = myProfilePageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
            
        case 2:
            // open "Conexoes"
            
            let conexoesViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ConexoesViewController") as! ConexoesViewController
            
            let conexoesPageNav = UINavigationController(rootViewController: conexoesViewController)
            
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = conexoesPageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
       
        case 3:
            // open "Calendario"
            
            let calendarViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CalendarViewController") as! CalendarViewController
            
            let calendarPageNav = UINavigationController(rootViewController: calendarViewController)
            
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = calendarPageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break

        case 4:
            // open "Configuracoes"
            
            let settingsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
            
            let settingsPageNav = UINavigationController(rootViewController: settingsViewController)
            
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = settingsPageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
     
        case 5:
            // open "Sobre"
            
            let aboutViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
            
            let aboutPageNav = UINavigationController(rootViewController: aboutViewController)
            
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.drawerContainer!.centerViewController = aboutPageNav
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
    
        case 6:
            // open "Parceiros"
            
            let partnersViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PartnersViewController") as! PartnersViewController
            
            let partnersPageNav = UINavigationController(rootViewController: partnersViewController)
            
            
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
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
                
                let loginPage:LoginViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                
                let loginPageNav = UINavigationController(rootViewController:loginPage)
                
                let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = loginPageNav
                
                
            }
            
            
            
            break
            
        default:
            print("Option is not handled")
            
        }
        
    }
    @IBAction func editProfileButton(sender: AnyObject) {
        let editProfile = self.storyboard?.instantiateViewControllerWithIdentifier("EditProfileViewController") as! EditProfileViewController
        editProfile.opener = self
        
        let editProfileNav = UINavigationController(rootViewController: editProfile)
        
        self.presentViewController(editProfileNav, animated: true, completion: nil)
    }
    
    func loadUserDetails() {
        
        
        let userType = PFUser.currentUser()?.objectForKey("profile_type") as! String
        
        if(userType == "Jogador"){
            
            let query1 = PFQuery(className:"UserPlayer")
            query1.includeKey("playerKey")
            query1.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        let userFirstName = object["first_name"]  as? String
                        let userLastName =  object["last_name"]  as? String
                        let profilePictureObject = object["profile_picture"] as? PFFile
                        
                        self.userFullNameLabel.text = userFirstName! + " " + userLastName!
                        profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                            
                            if(imageData != nil)
                            {
                                self.userProfilePicture.image = UIImage(data: imageData!)
                            }
                            
                        }
                    }
                }
            }
            
            
            
        }
    
        if(userType == "Empresario"){
            
            let query1 = PFQuery(className:"UserEmpresario")
            query1.includeKey("playerKey")
            query1.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        let userFirstName = object["first_name"]  as! String
                        let userLastName =  object["last_name"]  as! String
                        let profilePictureObject = object["profile_picture"] as! PFFile
                        
                        self.userFullNameLabel.text = userFirstName + " " + userLastName
                        profilePictureObject.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                            
                            if(imageData != nil)
                            {
                                self.userProfilePicture.image = UIImage(data: imageData!)
                            }
                            
                        }

                    }
                }
            }
            
            
        }
        
        if(userType == "Clube"){
            
            let query1 = PFQuery(className:"UserClube")
            query1.includeKey("playerKey")
            query1.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        let userFirstName = object["first_name"]  as! String
                        let userLastName =  object["last_name"]  as! String
                        
                        
                        self.userFullNameLabel.text = userFirstName + " " + userLastName
                        
                    }
                }
            }
            
            //let userFirstName = PFUser.currentUser()?.objectForKey("first_name") as! String
            //let userLastName = PFUser.currentUser()?.objectForKey("last_name") as! String
            
            
            let profilePictureObject = PFUser.currentUser()?.objectForKey("profile_picture") as! PFFile
            
            profilePictureObject.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                
                if(imageData != nil)
                {
                    self.userProfilePicture.image = UIImage(data: imageData!)
                }
                
            }
            
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
