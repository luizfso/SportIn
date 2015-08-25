//
//  RegisterViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/23/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userCPFText: UITextField!
    @IBOutlet weak var userPasswordText: UITextField!
    @IBOutlet weak var userPassVerifText: UITextField!
    
    
    let userType = ["Jogador", "Empresario", "Clube"]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userType.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return userType[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var newBackgroundColor : UIColor
        
        switch row {
        case 0:
            println("Jogador Selecionado")
            //newBackgroundColor = UIColor.yellowColor()
        case 1:
            //newBackgroundColor = UIColor.darkGrayColor()
            println("Empresario Selecionado")
        case 2:
            //newBackgroundColor = UIColor.lightGrayColor()
            println("Clube Selecionado")
        default:
            //newBackgroundColor = UIColor(red: 200/255, green: 255/255, blue: 200/255, alpha: 1.0)
            println("Nada Selecionado")
        }
        
        //self.view.backgroundColor = newBackgroundColor
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        profileImgView.layer.cornerRadius = 10 //profilePictureImageView.frame.size.width/3
        profileImgView.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectProfilePhotoButton(sender: AnyObject) {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        
        profileImgView.image = info[UIImagePickerControllerOriginalImage] as? UIImage

        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func registrarButton(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        let userName = userEmailTextField.text
        let userPassword = userPasswordText.text
        let userPasswordVerif = userPassVerifText.text
        let userFirstName = userFirstNameTextField.text
        let userLastName = userLastNameTextField.text
        let userCPF = userCPFText.text
        
        if(userName.isEmpty || userPassword.isEmpty || userPasswordVerif.isEmpty || userFirstName.isEmpty || userLastName.isEmpty)
        {
            
            var myAlert = UIAlertController(title:"Alert", message:"All fields are required to fill in", preferredStyle:UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        if(userPassword != userPasswordVerif)
        {
            var myAlert = UIAlertController(title:"Alert", message:"Passwords do not match. Please try again", preferredStyle:UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        let myUser:PFUser = PFUser()
        myUser.username = userName
        myUser.password = userPassword
        myUser.email = userName
        myUser.setObject(userFirstName, forKey: "first_name")
        myUser.setObject(userLastName, forKey: "last_name")
        
        //let profileBlankImg = UIImage(named:"profile_pic_512")
        
        let profileImgData = UIImageJPEGRepresentation(profileImgView.image, 1)
        
        if(profileImgData != nil)
        {
            let profileImageFile = PFFile(data: profileImgData)
            myUser.setObject(profileImageFile, forKey: "profile_picture")
        }
        
        // Show activity indicator
        let spiningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        spiningActivity.labelText = "Sending"
        spiningActivity.detailsLabelText = "Please wait"
        
        myUser.signUpInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            
            // Hide activity indicator
            spiningActivity.hide(true)
            
            var userMessage = "Registration is successful. Thank you!"
            
            if(!success)
            {
                //userMessage = "Could not register at this time please try again later."
                userMessage = error!.localizedDescription
            }
            
            
            var myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle:UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){ action in
                
                if(success)
                {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                
            }
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
