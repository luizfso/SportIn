//
//  RecoverViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/23/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//

import UIKit
import Parse

class RecoverViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailAddressTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recoverButton(sender: AnyObject) {
        
        let emailAddress = emailAddressTextField.text
        
        if emailAddress.isEmpty
        {
            // Display a warning message
            let userMessage:String = "please type in your email address"
            displayMessage(userMessage)
            return
        }
        
        
        PFUser.requestPasswordResetForEmailInBackground(emailAddress, block: { (success:Bool, error:NSError?) -> Void in
            
            if(error != nil)
            {
                // Display error message
                let userMessage:String = error!.localizedDescription
                self.displayMessage(userMessage)
            } else {
                // Display success message
                let userMessage:String = "An email message was sent to you \(emailAddress)"
                self.displayMessage(userMessage)
            }
            
        })
        
    }
    
    func displayMessage(userMessage:String)
    {
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.Default) {
            action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated:true, completion:nil)
    }

    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
