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


class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate{

    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
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
        
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile","email","user_friends"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    
    {
        if(error != nil)
        {
            println(error.localizedDescription)
            return
        }
        
        if let userToken = result.token
        {
            //get user access token
            let token:FBSDKAccessToken = result.token
            
            println("Token = \(FBSDKAccessToken.currentAccessToken().tokenString)")
            println("User ID = \(FBSDKAccessToken.currentAccessToken().userID)")
        
            let registerPage = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterViewController") as! RegisterViewController
        
            let registerPageNav = UINavigationController (rootViewController: registerPage)
            
            let appDelagate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelagate.window?.rootViewController = registerPageNav
            
            //alteracao
        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        println("user is logged out")
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        userEmailTextField.resignFirstResponder()
        userPasswordTextField.resignFirstResponder()
        
        return true
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
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
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
