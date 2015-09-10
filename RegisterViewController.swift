//
//  RegisterViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/23/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userCPFText: UITextField!
    @IBOutlet weak var userPasswordText: UITextField!
    @IBOutlet weak var userPassVerifText: UITextField!
    @IBOutlet weak var userTypeSelected: UITextField!
    
    
    let userType = ["Selecionar Meu Perfil","Jogador", "Empresario", "Clube"]
    
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
            println("Selecionar Meu Perfil")
            //newBackgroundColor = UIColor.yellowColor()
            userTypeSelected.text = ""
            println("Nada Selecionado")
            
        case 1:
            println("Jogador Selecionado")
            //newBackgroundColor = UIColor.yellowColor()
            let pickedProfile = userType[row]
            userTypeSelected.text = pickedProfile
            
        case 2:
            println("Empresario Selecionado")
            //newBackgroundColor = UIColor.darkGrayColor()
            let pickedProfile = userType[row]
            userTypeSelected.text = pickedProfile
            
        case 3:
            //newBackgroundColor = UIColor.lightGrayColor()
            println("Clube Selecionado")
            let pickedProfile = userType[row]
            userTypeSelected.text = pickedProfile
            
        default:
            //newBackgroundColor = UIColor(red: 200/255, green: 255/255, blue: 200/255, alpha: 1.0)
            userTypeSelected.text = ""
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
        
        let userEmail = userEmailTextField.text
        let userFirstName = userFirstNameTextField.text
        let userLastName = userLastNameTextField.text
        let userPassword = userPasswordText.text
        let userPasswordVerif = userPassVerifText.text
        let selectedProfile = userTypeSelected.text
        let userCPF = userCPFText.text
        
        
        if(userEmail.isEmpty || userPassword.isEmpty || userPasswordVerif.isEmpty || userFirstName.isEmpty || userLastName.isEmpty || userCPF.isEmpty)
        {
            
            var myAlert = UIAlertController(title:"Alert", message:"Todos os campos devem ser preenchidos", preferredStyle:UIAlertControllerStyle.Alert)
            
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

        if(selectedProfile == "")
        {
            
            var myAlert = UIAlertController(title:"Alert", message:"Selecione ao menos uma opção para seu perfil", preferredStyle:UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }

        
        if(selectedProfile == "Jogador")
        {
        
       /* let myUserPlayer = PFObject(className: "UserPlayer")
            myUserPlayer["playerKey"] = ""
            myUserPlayer.saveInBackground()
           */
        let myUser:PFUser = PFUser()
        myUser.username = userEmail
        myUser.password = userPassword
        myUser.email = userEmail
        myUser.setObject(userFirstName, forKey: "first_name")
        myUser.setObject(userLastName, forKey: "last_name")
        myUser.setObject(userCPF, forKey: "user_CPF")
        myUser.setObject(selectedProfile, forKey: "profile_type")
            
            //let gameQuery = PFQuery(className:"UserPlayer")
            //if let user = PFUser.currentUser() {
            //    gameQuery.whereKey("playerKey", equalTo: user)
            //}
            
            //let myUserPlayer = PFObject(className: "UserPlayer")
           
            
        
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
                    
                    
                    //myUserPlayer["playerKey"] = PFUser.currentUser()
                    //myUserPlayer.saveInBackground()
                }
                
            }
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
        }
        
        }
        
        if(selectedProfile == "Empresario")
        {
            
            let myUser:PFUser = PFUser()
            myUser.username = userEmail
            myUser.password = userPassword
            myUser.email = userEmail
            myUser.setObject(selectedProfile, forKey: "profile_type")
            
            //var query = PFQuery(className:"User")
            //query.getObjectInBackgroundWithId("xWMyZEGZ")
            
            let myUserEmpresario:PFObject = PFObject(className: "UserEmpresario")
            myUserEmpresario["test"] = "teste"
            myUserEmpresario.setObject(userFirstName, forKey: "first_name")
            myUserEmpresario.setObject(userLastName, forKey: "last_name")
            myUserEmpresario.setObject(userCPF, forKey: "user_CPF")
            myUserEmpresario.setObject(selectedProfile, forKey: "keyUser")
            
            
            
            
            let profileImgData = UIImageJPEGRepresentation(profileImgView.image, 1)
            
            if(profileImgData != nil)
            {
                let profileImageFile = PFFile(data: profileImgData)
                myUserEmpresario.setObject(profileImageFile, forKey: "profile_picture")
            }
            
            // Show activity indicator
            let spiningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            spiningActivity.labelText = "Sending"
            spiningActivity.detailsLabelText = "Please wait"
            
            /*let myUserEmpresario:PFObject = PFObject(className: "UserEmpresario")
            let keyUserStored = PFUser.currentUser()?.objectForKey("objectId") as! String
            
            myUserEmpresario.setObject(keyUserStored, forKey: "keyUser")
            myUserEmpresario.saveInBackground()
            */
            
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
            myUserEmpresario.saveInBackground()
            
            println(myUser)
            
            println(myUser.objectId)
            
            myUser.objectId?.getMirror()
           
            /*
            let getId:PFObject = PFObject(className: "UserEmpresario")
            let id = getId.objectId
            println(id)
            
            var query = PFObject(className:"User")
            query.whereKeyExists("objectId")
            query = PFObject.objectForKey("objectId") as! String
            println(query)
            
            var queryEmp = PFQuery(className:"UserEmpresario")
            queryEmp.whereKeyExists("objectId")
            println(queryEmp)
*/
            
        }
        
        
        if(selectedProfile == "Clube")
        {
            
            let myUser:PFUser = PFUser()
            myUser.username = userEmail
            myUser.password = userPassword
            myUser.email = userEmail
            
            let myUserClube:PFObject = PFObject(className: "UserClube")
            myUserClube["test"] = "teste"
            myUserClube.setObject(userFirstName, forKey: "first_name")
            myUserClube.setObject(userLastName, forKey: "last_name")
            myUserClube.setObject(userCPF, forKey: "user_CPF")
            myUserClube.setObject(selectedProfile, forKey: "profile_type")
            
            //let profileBlankImg = UIImage(named:"profile_pic_512")
            
            let profileImgData = UIImageJPEGRepresentation(profileImgView.image, 1)
            
            if(profileImgData != nil)
            {
                let profileImageFile = PFFile(data: profileImgData)
                myUserClube.setObject(profileImageFile, forKey: "profile_picture")
            }
            
            // Show activity indicator
            let spiningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            spiningActivity.labelText = "Sending"
            spiningActivity.detailsLabelText = "Please wait"
            
            myUser.signUpInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
                myUserClube.saveInBackground()
                
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
        
        
        //let myUserPlayer = PFObject(className: "UserPlayer")
        //myUserPlayer["playerKey"] = PFUser.object(id)
        //myUserPlayer.saveInBackground()
        
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
