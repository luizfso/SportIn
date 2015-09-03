//
//  LoginViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/23/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import FBSDKLoginKit
import FBSDKCoreKit


class LoginViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        // codigo para personalizar o navigationBar
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //let logotipo = UIImage(named: "logoSmall.png")
        //let imageCenter = UIImageView(image: logotipo)
        //self.navigationItem.titleView = imageCenter;
        
        
        if(FBSDKAccessToken.currentAccessToken() == nil)
        {
            println("user is not logged in")
        }else{
            println("user is logged in")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        
        if(userEmail.isEmpty || userPassword.isEmpty)
        {
            return
        }
        
        
        let spiningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        spiningActivity.labelText = "Sending"
        spiningActivity.detailsLabelText = "Please wait"
        //spiningActivity.userInteractionEnabled = false
        
        
        PFUser.logInWithUsernameInBackground(userEmail, password: userPassword) { (user:PFUser?, error:NSError?) -> Void in
            
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            
            
            var userMessage = "Welcome!"
            
            if(user != nil)
            {
                
                // Remember the sign in state
                let userName:String? = user?.username
                
                NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                // Navigate to Protected page
                
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                appDelegate.buildUserInterface()
                

            } else {
                
                userMessage = error!.localizedDescription
                var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                
                myAlert.addAction(okAction)
                
                self.presentViewController(myAlert, animated: true, completion: nil)
            }
            
            
        }
        
        
    }
    
    @IBAction func createNewAccount(sender: AnyObject) {
    }
    
    @IBAction func loginWithFacebook(sender: AnyObject) {
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile","email"], block: {(user:PFUser?, error:NSError?) -> Void in
            
            if(error != nil)
            {
                //DIsplay alert and message error
                var myAlert = UIAlertController(title:"Alert", message:error?.localizedDescription , preferredStyle: UIAlertControllerStyle.Alert);
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                myAlert.addAction(okAction);
                self.presentViewController(myAlert, animated: true, completion: nil);
                
                return
            }
            
            let userName:String? = user?.username
            
            NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            println(user)
            println("Current user token=\(FBSDKAccessToken.currentAccessToken().tokenString)")
            
            println("Current user id=\(FBSDKAccessToken.currentAccessToken().userID)")
            
            if(FBSDKAccessToken.currentAccessToken() != nil)
            {
                
                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                appDelegate.buildUserInterface()
            }
            
        })

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

//
//  ViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/3/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//
