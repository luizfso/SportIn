//
//  EditProfileViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/23/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var parcInfoView: UIView!
    @IBOutlet weak var proInfoView: UIView!
    @IBOutlet weak var videoInfoView: UIView!
    @IBOutlet weak var featuresInfoView: UIView!
    @IBOutlet weak var contactInfoView: UIView!
    
    
    
    @IBOutlet weak var typeEdit: UISegmentedControl!
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var userFNameTextField: UITextField!
    @IBOutlet weak var userLNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordVerifTextField: UITextField!
    @IBOutlet weak var CPFTextField: UITextField!
    @IBOutlet weak var nascDataTextField: UITextField!
    @IBOutlet weak var apelidoTextField: UITextField!
    @IBOutlet weak var generoTextField: UITextField!
    @IBOutlet weak var nacionalidadeTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    var opener: MenuViewController!
    
    let typeOfEdit: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // codigo para personalizar o navigationBar
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        //Hidden Others Views
        self.parcInfoView.hidden = false
        self.proInfoView.hidden = true
        self.videoInfoView.hidden = true
        self.featuresInfoView.hidden = true
        self.contactInfoView.hidden = true
        
        //Circular Image
        profilePictureImageView.layer.cornerRadius = 10 //profilePictureImageView.frame.size.width/3
        profilePictureImageView.clipsToBounds = true
        profilePictureImageView.layer.borderWidth = 1
        profilePictureImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        
        // Load user details
        let userFName = PFUser.currentUser()?.objectForKey("first_name") as! String
        let userLName = PFUser.currentUser()?.objectForKey("last_name") as! String
        
        userFNameTextField.text = userFName
        userLNameTextField.text = userLName
        
        
        if(PFUser.currentUser()?.objectForKey("profile_picture") != nil)
        {
            let userImageFile:PFFile = PFUser.currentUser()?.objectForKey("profile_picture") as! PFFile
            
            userImageFile.getDataInBackgroundWithBlock({ (imageData: NSData?, error: NSError?) -> Void in
                
                if(imageData != nil)
                {
                    self.profilePictureImageView.image = UIImage(data: imageData!)
                }
                
            })
        }
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectTypeEdit(sender: AnyObject) {
        if typeEdit.selectedSegmentIndex == 0{
            println("Personal info")
            self.parcInfoView.hidden = false
            self.proInfoView.hidden = true
            self.videoInfoView.hidden = true
            self.featuresInfoView.hidden = true
            self.contactInfoView.hidden = true
            
        }
        if typeEdit.selectedSegmentIndex == 1{
            println("Professional info")
            self.parcInfoView.hidden = true
            self.proInfoView.hidden = false
            self.videoInfoView.hidden = true
            self.featuresInfoView.hidden = true
            self.contactInfoView.hidden = true
        }
        if typeEdit.selectedSegmentIndex == 2{
            println("Video info")
            self.parcInfoView.hidden = true
            self.proInfoView.hidden = true
            self.videoInfoView.hidden = false
            self.featuresInfoView.hidden = true
            self.contactInfoView.hidden = true
        }
        if typeEdit.selectedSegmentIndex == 3{
            println("Features info")
            self.parcInfoView.hidden = true
            self.proInfoView.hidden = true
            self.videoInfoView.hidden = true
            self.featuresInfoView.hidden = false
            self.contactInfoView.hidden = true
        }
        if typeEdit.selectedSegmentIndex == 4{
            println("Features info")
            self.parcInfoView.hidden = true
            self.proInfoView.hidden = true
            self.videoInfoView.hidden = true
            self.featuresInfoView.hidden = true
            self.contactInfoView.hidden = false
        }
    
    }
    
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func chooseProfileButtonTapped(sender: AnyObject) {
        
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        profilePictureImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func saveButton(sender: AnyObject) {
        
        // Get current user
        let myUser:PFUser = PFUser.currentUser()!
        
        // Get profile image data
        let profileImageData = UIImageJPEGRepresentation(profilePictureImageView.image, 1)
        
        // Check if all fields are empty
        if(passwordTextField.text.isEmpty && userFNameTextField.text.isEmpty && userLNameTextField.text.isEmpty && (profileImageData == nil))
        {
            
            var myAlert = UIAlertController(title:"Alert", message:"All fields cannot be empty", preferredStyle: UIAlertControllerStyle.Alert);
            
            let okAction =  UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(okAction);
            self.presentViewController(myAlert, animated:true, completion:nil);
            return
        }
        
        // If user decided to update their password make sure there is no typo
        if(!passwordTextField.text.isEmpty && (passwordTextField.text != passwordVerifTextField.text))
        {
            var myAlert = UIAlertController(title:"Alert", message:"Passwords do not match", preferredStyle: UIAlertControllerStyle.Alert);
            
            let okAction =  UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(okAction);
            self.presentViewController(myAlert, animated:true, completion:nil);
            
            return;
        }
        
        // Check if First name and Last name are not empty
        if(userFNameTextField.text.isEmpty || userLNameTextField.text.isEmpty)
        {
            
            var myAlert = UIAlertController(title:"Alert", message:"First name and Last name are required fields", preferredStyle: UIAlertControllerStyle.Alert);
            
            let okAction =  UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(okAction);
            self.presentViewController(myAlert, animated:true, completion:nil);
            
            return
        }
        
        // Set new values for user first name and last name
        let userFName = userFNameTextField.text
        let userLName = userLNameTextField.text
        let userCPF = CPFTextField.text
        let userBirth = nascDataTextField.text
        let userApelido = apelidoTextField.text
        let userGen = generoTextField.text
        let userNationality = nacionalidadeTextField.text
        let userAddress = addressTextField.text
        
        myUser.setObject(userFName, forKey: "first_name")
        myUser.setObject(userLName, forKey: "last_name")
        myUser.setObject(userCPF, forKey: "user_CPF")
        myUser.setObject(userBirth, forKey: "user_birth")
        myUser.setObject(userApelido, forKey: "user_apelido")
        myUser.setObject(userGen, forKey: "user_gen")
        myUser.setObject(userNationality, forKey: "user_natio")
        myUser.setObject(userAddress, forKey: "user_address")
        
        // set new password
        if(!passwordTextField.text.isEmpty)
        {
            let userPassword = passwordTextField.text
            myUser.password = userPassword
        }
        
        
        // Set profile picture
        if(profileImageData != nil)
        {
            let profileFileObject = PFFile(data:profileImageData)
            myUser.setObject(profileFileObject, forKey: "profile_picture")
        }
        
        // Display activity indicator
        let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loadingNotification.labelText = "Please wait"
        
        myUser.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            
            // Hide activity indicator
            loadingNotification.hide(true)
            
            if(error != nil)
            {
                
                var myAlert = UIAlertController(title:"Alert", message:error!.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert);
                
                let okAction =  UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                myAlert.addAction(okAction);
                self.presentViewController(myAlert, animated:true, completion:nil);
                
                return
            }
            
            
            if(success)
            {
                
                var userMessage = "Profile details successfully updated"
                var myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.Alert);
                
                let okAction =  UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                    
                    self.dismissViewControllerAnimated(true, completion: { () -> Void in
                        self.opener.loadUserDetails()
                    })
                    
                })
                
                myAlert.addAction(okAction);
                self.presentViewController(myAlert, animated:true, completion:nil);
                
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
