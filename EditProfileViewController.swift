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
    
    //user Personal Info
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
    
    //Professional Info
    @IBOutlet weak var userModalTextField: UITextField!
    @IBOutlet weak var userKickFootTextField: UITextField!
    @IBOutlet weak var userHightTextField: UITextField!
    @IBOutlet weak var userWeightTextField: UITextField!
    @IBOutlet weak var userNumFootTextField: UITextField!
    @IBOutlet weak var userPositionTextField: UITextField!
    @IBOutlet weak var userLevelTextField: UITextField!
    
    //user link videos Info
    @IBOutlet weak var userLinkOneTextField: UITextField!
    @IBOutlet weak var userLinkTwoTextField: UITextField!
    @IBOutlet weak var userLinkThreeTextField: UITextField!
    @IBOutlet weak var userLinkFourTextField: UITextField!
    
    //User Features Info
    @IBOutlet weak var userGradeTextField: UITextField!
    @IBOutlet weak var userMemberClubTextField: UITextField!
    @IBOutlet weak var userTeamDreamTextField: UITextField!
    @IBOutlet weak var userPrefBrandsTextField: UITextField!
    @IBOutlet weak var userFederatedTextField: UITextField!
    
    //User Contact Info
    @IBOutlet weak var userEmailProTextField: UITextField!
    @IBOutlet weak var userFBLinkPageTextField: UITextField!
    @IBOutlet weak var userLInLinkPageTextField: UITextField!
    @IBOutlet weak var userTwtLinkPageTextField: UITextField!
    @IBOutlet weak var userCellPhoneTextField: UITextField!
    
    
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
        profilePictureImageView.layer.cornerRadius = 11 //profilePictureImageView.frame.size.width/3
        profilePictureImageView.clipsToBounds = true
        profilePictureImageView.layer.borderWidth = 1
        profilePictureImageView.layer.borderColor = UIColor.whiteColor().CGColor
        
        
        
        // Load user details if they no Blanks
        /*
        ==========================================================================================
        Load Personal Info
        ==========================================================================================
        */
        let userFName = PFUser.currentUser()?.objectForKey("first_name") as! String
        userFNameTextField.text = userFName
        
        let userLName = PFUser.currentUser()?.objectForKey("last_name") as! String
        userLNameTextField.text = userLName
        
        let userCPF = PFUser.currentUser()?.objectForKey("user_CPF") as! String
        CPFTextField.text = userCPF
        
        let userBirth = PFUser.currentUser()?.objectForKey("user_birth") as! String
        nascDataTextField.text = userBirth
        
        let userApelido = PFUser.currentUser()?.objectForKey("user_apelido") as! String
        apelidoTextField.text = userApelido

        let userGen = PFUser.currentUser()?.objectForKey("user_gen") as! String
        generoTextField.text = userGen
        
        let userNationality = PFUser.currentUser()?.objectForKey("user_natio") as! String
        nacionalidadeTextField.text = userNationality
        
        let userAddress = PFUser.currentUser()?.objectForKey("user_address") as! String
        addressTextField.text = userAddress
        
        // Password is in another position on this code
        
        /*
        ==========================================================================================
        Load Professional Info
        ==========================================================================================
        */
        
        let userModal = PFUser.currentUser()?.objectForKey("user_modal") as! String
        userModalTextField.text = userModal
        
        let userKickFoot = PFUser.currentUser()?.objectForKey("user_kickfoot") as! String
        userKickFootTextField.text = userKickFoot
        
        let userHight = PFUser.currentUser()?.objectForKey("user_height") as! String
        userHightTextField.text = userHight
        
        let userWeight = PFUser.currentUser()?.objectForKey("user_weight") as! String
        userWeightTextField.text = userWeight
        
        
        let userNumFoot = PFUser.currentUser()?.objectForKey("user_numfoot") as! String
        userNumFootTextField.text = userNumFoot
        let userPosition = PFUser.currentUser()?.objectForKey("user_position") as! String
        userPositionTextField.text = userPosition
        let userLevel = PFUser.currentUser()?.objectForKey("user_level") as! String
        userLevelTextField.text = userLevel
        
        /*
        ==========================================================================================
        Load Link Info
        ==========================================================================================
        */
        
        let userLk1 = PFUser.currentUser()?.objectForKey("user_linkone") as! String
        userLinkOneTextField.text = userLk1
        let userLk2 = PFUser.currentUser()?.objectForKey("user_linktwo") as! String
        userLinkTwoTextField.text = userLk2
        let userLk3 = PFUser.currentUser()?.objectForKey("user_linktree") as! String
        userLinkThreeTextField.text = userLk3
        let userLk4 = PFUser.currentUser()?.objectForKey("user_linkfour") as! String
        userLinkOneTextField.text = userLk4
        
        /*
        ==========================================================================================
        Load Plus Informations
        ==========================================================================================
        */
        
        
        let userSchool = PFUser.currentUser()?.objectForKey("user_grade") as! String
        userGradeTextField.text = userSchool
        let userMClub = PFUser.currentUser()?.objectForKey("user_menberclub") as! String
        userMemberClubTextField.text = userMClub
        let userDream = PFUser.currentUser()?.objectForKey("user_teamdream") as! String
        userTeamDreamTextField.text = userDream
        let userBrands = PFUser.currentUser()?.objectForKey("user_prefbrands") as! String
        userPrefBrandsTextField.text = userBrands
        let userFed = PFUser.currentUser()?.objectForKey("user_federated") as! String
        userFederatedTextField.text = userFed
        
        /*
        ==========================================================================================
        Load Contact Informations
        ==========================================================================================
        */
        
        let userMPro = PFUser.currentUser()?.objectForKey("user_emailpro") as! String
        userEmailProTextField.text = userMPro
        let userFBLPage = PFUser.currentUser()?.objectForKey("user_fbpage") as! String
        userFBLinkPageTextField.text = userFBLPage
        let userLNLPage = PFUser.currentUser()?.objectForKey("user_lipage") as! String
        userLInLinkPageTextField.text = userLNLPage
        let userTWLinkPage = PFUser.currentUser()?.objectForKey("user_twtpage") as! String
        userTwtLinkPageTextField.text = userTWLinkPage
        let userMobile = PFUser.currentUser()?.objectForKey("user_cellphone") as! String
        userCellPhoneTextField.text = userMobile
        
      
        /*
        ==========================================================================================
        Load Picture User
        ==========================================================================================
        */
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
        
        // Set new values for Pro Info
        let userMod = userModalTextField.text
        let userKFoot = userKickFootTextField.text
        let userHth = userHightTextField.text
        let userWth = userWeightTextField.text
        let userNmFoot = userNumFootTextField.text
        let userPos = userPositionTextField.text
        let userLvl = userLevelTextField.text
        
        // Set new values for Pro Info
        let userLk1 = userLinkOneTextField.text
        let userLk2 = userLinkTwoTextField.text
        let userLk3 = userLinkThreeTextField.text
        let userLk4 = userLinkFourTextField.text
        
        // Set new values for Pro Info
        let userSchool = userGradeTextField.text
        let userMClub = userMemberClubTextField.text
        let userDream = userTeamDreamTextField.text
        let userBrands = userPrefBrandsTextField.text
        let userFed = userFederatedTextField.text
        
        // Set new values for Pro Info
        let userMPro = userEmailProTextField.text
        let userFBLPage = userFBLinkPageTextField.text
        let userLNLPage = userLInLinkPageTextField.text
        let userTWLinkPage = userTwtLinkPageTextField.text
        let userMobile = userCellPhoneTextField.text
        
        
        // Set new values for Personal Info
        myUser.setObject(userFName, forKey: "first_name")
        myUser.setObject(userLName, forKey: "last_name")
        myUser.setObject(userCPF, forKey: "user_CPF")
        myUser.setObject(userBirth, forKey: "user_birth")
        myUser.setObject(userApelido, forKey: "user_apelido")
        myUser.setObject(userGen, forKey: "user_gen")
        myUser.setObject(userNationality, forKey: "user_natio")
        myUser.setObject(userAddress, forKey: "user_address")
        
        // Set new values for Pro Info
        myUser.setObject(userMod, forKey: "user_modal")
        myUser.setObject(userKFoot, forKey: "user_kickfoot")
        myUser.setObject(userHth, forKey: "user_height")
        myUser.setObject(userWth, forKey: "user_weight")
        myUser.setObject(userNmFoot, forKey: "user_numfoot")
        myUser.setObject(userPos, forKey: "user_position")
        myUser.setObject(userLvl, forKey: "user_level")
        
        // Set new values for Pro Info
        myUser.setObject(userLk1, forKey: "user_linkone")
        myUser.setObject(userLk2, forKey: "user_linktwo")
        myUser.setObject(userLk3, forKey: "user_linktree")
        myUser.setObject(userLk4, forKey: "user_linkfour")
        
        // Set new values for Pro Info
        myUser.setObject(userSchool, forKey: "user_grade")
        myUser.setObject(userMClub, forKey: "user_menberclub")
        myUser.setObject(userDream, forKey: "user_teamdream")
        myUser.setObject(userBrands, forKey: "user_prefbrands")
        myUser.setObject(userFed, forKey: "user_federated")
        
        // Set new values for Pro Info
        myUser.setObject(userMPro, forKey: "user_emailpro")
        myUser.setObject(userFBLPage, forKey: "user_fbpage")
        myUser.setObject(userLNLPage, forKey: "user_lipage")
        myUser.setObject(userTWLinkPage, forKey: "user_twtpage")
        myUser.setObject(userMobile, forKey: "user_cellphone")
        
        
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
