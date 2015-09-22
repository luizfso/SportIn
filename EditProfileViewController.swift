//
//  EditProfileViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/23/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//?

import UIKit
import Parse

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
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
    @IBOutlet weak var CNPJTextField: UITextField!
    @IBOutlet weak var nascDataTextField: UITextField!
    @IBOutlet weak var apelidoTextField: UITextField!
    @IBOutlet weak var generoTextField: UITextField!
    @IBOutlet weak var nacionalidadeTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    
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
        
        let user:PFUser = PFUser.currentUser()!
        
        let userProfileType = PFUser.currentUser()?.objectForKey("profile_type") as? String
        
        
        /*
        ==========================================================================================
        Verify Profile Type and Load Info - Jogador
        ==========================================================================================
        */
        
        if userProfileType == "Jogador"{
            
            //let sameuser:PFObject = PFObject(className: "UserPlayer")
            
            var query = PFQuery(className:"UserPlayer")
            query.includeKey("playerKey")
            query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                
                
                if let objects = objects as? [PFObject]{
                    
                    for object in objects {
                        
                        // Load user details if they no Blanks
                        /*
                        ==========================================================================================
                        Load Personal Info - Jogador
                        ==========================================================================================
                        */
                        
                        let userFirstName = object["first_name"] as? String
                        self.userFNameTextField.text = userFirstName
                        
                        let userLastName = object["last_name"] as? String
                        self.userLNameTextField.text = userLastName
                        
                        let userCPF = object["pCPF"] as? String
                        self.CPFTextField.text = userCPF
                        
                        // Hide no CNPJ se for Jogador
                        self.CNPJTextField.hidden = true
                        
                        
                        let userApelido = object["pApelido"] as? String
                        self.apelidoTextField.text = userApelido
                        
                        let userGen = object["pGenero"] as? String
                        self.generoTextField.text = userGen
                        
                        let userBirth = object["pNascimento"] as? String
                        self.nascDataTextField.text = userBirth
                        
                        let userNationality = object["pNacionalidade"] as? String
                        self.nacionalidadeTextField.text = userNationality
                        
                        let userAddress = object["pEndereco"] as? String
                        self.addressTextField.text = userAddress
                        
                        let userCity = object["pCidade"] as? String
                        self.addressTextField.text = userAddress
                        
                        let userState = object["pEstado"] as? String
                        self.addressTextField.text = userAddress
                        
                        // Password is in another position on this code
                        
                        /*
                        ==========================================================================================
                        Load Professional Info - Jogador
                        ==========================================================================================
                        */
                        
                        var userModal = object["pModalidade"] as? String
                        self.userModalTextField.text = userModal
                        
                        var userKickFoot = object["pKickfoot"] as? String
                        self.userKickFootTextField.text = userKickFoot
                        
                        var userHight = object["pAltura"] as? String
                        self.userHightTextField.text = userHight
                        
                        var userWeight = object["pPeso"] as? String
                        self.userWeightTextField.text = userWeight
                        
                        var userNumFoot = object["pNumfoot"] as? String
                        self.userNumFootTextField.text = userNumFoot
                        
                        var userPosition = object["pPosicao"] as? String
                        self.userPositionTextField.text = userPosition
                        
                        var userLevel = object["pNivel"] as? String
                        self.userLevelTextField.text = userLevel
                        
                        
                        /*
                        ==========================================================================================
                        Load Plus Informations - Jogador
                        ==========================================================================================
                        */
                        
                        var userBrands = object["pPrefMarcas"] as? String
                        self.userLevelTextField.text = userBrands
                        
                        var userSchool = object["pEscolaridade"] as? String
                        self.userLevelTextField.text = userSchool
                        
                        var userMClub = object["pClube"] as? String
                        self.userLevelTextField.text = userMClub
                        
                        var userFed = object["pFederado"] as? String
                        self.userLevelTextField.text = userFed
                        
                        var userDream = object["pDreamTeam"] as? String
                        self.userLevelTextField.text = userDream
                        
                        /*
                        ==========================================================================================
                        Load Contact Informations - Jogador
                        ==========================================================================================
                        */
                        
                        var userMobile = object["pCelular"] as? String
                        self.userLevelTextField.text = userMobile
                        
                        var userFBLPage = object["pFB"] as? String
                        self.userLevelTextField.text = userFBLPage
                        
                        var userTWLinkPage = object["pTwitter"] as? String
                        self.userLevelTextField.text = userTWLinkPage
                        
                        var userLNLPage = object["pLinkedIn"] as? String
                        self.userLevelTextField.text = userLNLPage
                        
                        var userMPro = object["pEmailPro"] as? String
                        self.userLevelTextField.text = userMPro
                        
                        /*
                        ==========================================================================================
                        Load Link Info - Jogador
                        ==========================================================================================
                        */
                        
                        var userLk1 = object["pLink1"] as? String
                        self.userLevelTextField.text = userLk1
                        
                        var userLk2 = object["pLink2"] as? String
                        self.userLevelTextField.text = userLk2
                        
                        var userLk3 = object["pLink3"] as? String
                        self.userLevelTextField.text = userLk3
                        
                        var userLk4 = object["pLink4"] as? String
                        self.userLevelTextField.text = userLk4
                    }
                }
            }
            
            /*
            ==========================================================================================
            Load Picture User - Jogador
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
        
        
        
        
        
        
        /*
        ==========================================================================================
        Verify Profile Type and Load Info - Empresario
        ==========================================================================================
        */
        if userProfileType == "Empresario"{
            
            //let sameuser:PFObject = PFObject(className: "UserPlayer")
            
            var query = PFQuery(className:"UserEmpresario")
            query.includeKey("empKey")
            query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                
                
                if let objects = objects as? [PFObject]{
                    
                    for object in objects {
                        
                        // Load user details if they no Blanks
                        /*
                        ==========================================================================================
                        Load Personal Info - Empresario
                        ==========================================================================================
                        */
                        
                        let userFirstName = object["first_name"] as? String
                        self.userFNameTextField.text = userFirstName
                        
                        let userLastName = object["last_name"] as? String
                        self.userLNameTextField.text = userLastName
                        
                        let userCPF = object["eCPF"] as? String
                        self.CPFTextField.text = userCPF
                        
                        let userCNPJ = object["eCNPJ"] as? String
                        self.CNPJTextField.text = userCNPJ
                        
                        let userApelido = object["eApelido"] as? String
                        self.apelidoTextField.text = userApelido
                        
                        let userGen = object["eGenero"] as? String
                        self.generoTextField.text = userGen
                        
                        let userBirth = object["eNascimento"] as? String
                        self.nascDataTextField.text = userBirth
                        
                        let userNationality = object["eNacionalidade"] as? String
                        self.nacionalidadeTextField.text = userNationality
                        
                        let userAddress = object["eEndereco"] as? String
                        self.addressTextField.text = userAddress
                        
                        let userCity = object["eCidade"] as? String
                        self.addressTextField.text = userAddress
                        
                        let userState = object["eEstado"] as? String
                        self.addressTextField.text = userAddress
                        
                        // Password is in another position on this code
                        
                        /*
                        ==========================================================================================
                        Load Professional Info - Empresario
                        ==========================================================================================
                        */
                        
                        var userModal =  object["eModalidade"] as? String
                        self.userModalTextField.text = userModal
                        
                        self.userKickFootTextField.hidden = true
                        
                        self.userHightTextField.hidden = true
                        
                        self.userWeightTextField.hidden = true
                        
                        self.userNumFootTextField.hidden = true
                        
                        self.userPositionTextField.hidden = true
                        
                        var userLevel =  object["eNivel"] as? String
                        self.userLevelTextField.text = userLevel
                        
                        
                        /*
                        ==========================================================================================
                        Load Plus Informations - Empresario
                        ==========================================================================================
                        */
                        
                        var userBrands = object["ePrefMarcas"] as? String
                        self.userLevelTextField.text = userBrands
                        
                        var userSchool = object["eEscolaridade"] as? String
                        self.userLevelTextField.text = userSchool
                        
                        var userMClub = object["eClube"] as? String
                        self.userLevelTextField.text = userMClub
                        
                        var userFed = object["eFederado"] as? String
                        self.userLevelTextField.text = userFed
                        
                        self.userLevelTextField.hidden = true
                        
                        /*
                        ==========================================================================================
                        Load Contact Informations - Empresario
                        ==========================================================================================
                        */
                        
                        var userMobile = object["eCelular"] as? String
                        self.userLevelTextField.text = userMobile
                        
                        var userFBLPage = object["eFB"] as? String
                        self.userLevelTextField.text = userFBLPage
                        
                        var userTWLinkPage = object["eTwitter"] as? String
                        self.userLevelTextField.text = userTWLinkPage
                        
                        var userLNLPage = object["eLinkedIn"] as? String
                        self.userLevelTextField.text = userLNLPage
                        
                        var userMPro = object["eEmailPro"] as? String
                        self.userLevelTextField.text = userMPro
                        
                        /*
                        ==========================================================================================
                        Load Link Info - Empresario
                        ==========================================================================================
                        */
                        
                        self.userLevelTextField.hidden = true
                        
                        self.userLevelTextField.hidden = true
                        
                        self.userLevelTextField.hidden = true
                        
                        self.userLevelTextField.hidden = true
                        
                    }
                }
            }
            
            /*
            ==========================================================================================
            Load Picture User - Empresario
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
        
        
        
        
        /*
        ==========================================================================================
        Verify Profile Type and Load Info - Clube
        ==========================================================================================
        */
        if userProfileType == "Clube"{
            
            //let sameuser:PFObject = PFObject(className: "UserPlayer")
            
            var query = PFQuery(className:"UserClube")
            query.includeKey("clubeKey")
            query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                
                
                if let objects = objects as? [PFObject]{
                    
                    for object in objects {
                        
                        // Load user details if they no Blanks
                        /*
                        ==========================================================================================
                        Load Personal Info - Clube
                        ==========================================================================================
                        */
                        
                        let userFirstName = object["first_name"] as? String
                        self.userFNameTextField.text = userFirstName
                        
                        let userLastName = object["last_name"] as? String
                        self.userLNameTextField.text = userLastName
                        
                        let userCPF = object["cCPF"] as? String
                        self.CPFTextField.text = userCPF
                        
                        let userCNPJ = object["cCNPJ"] as? String
                        self.CNPJTextField.text = userCNPJ
                        
                        self.apelidoTextField.hidden = true
                        
                        let userGen = object["cGenero"] as? String
                        self.generoTextField.text = userGen
                        
                        let userBirth = object["cNascimento"] as? String
                        self.nascDataTextField.text = userBirth
                        
                        let userNationality = object["cNacionalidade"] as? String
                        self.nacionalidadeTextField.text = userNationality
                        
                        let userAddress = object["cEndereco"] as? String
                        self.addressTextField.text = userAddress
                        
                        let userCity = object["cCidade"] as? String
                        self.addressTextField.text = userAddress
                        
                        let userState = object["cEstado"] as? String
                        self.addressTextField.text = userAddress
                        
                        // Password is in another position on this code
                        
                        /*
                        ==========================================================================================
                        Load Professional Info - Clube
                        ==========================================================================================
                        */
                        
                        var userModal =  object["cModalidade"] as? String
                        self.userModalTextField.text = userModal
                        
                        self.userKickFootTextField.hidden = true
                        
                        self.userHightTextField.hidden = true
                        
                        self.userWeightTextField.hidden = true
                        
                        self.userNumFootTextField.hidden = true
                        
                        self.userPositionTextField.hidden = true
                        
                        self.userLevelTextField.hidden = true
                        
                        
                        /*
                        ==========================================================================================
                        Load Plus Informations - Clube
                        ==========================================================================================
                        */
                        
                        self.userLevelTextField.hidden = true
                        
                        self.userLevelTextField.hidden = true
                        
                        var userMClub = object["cClube"] as? String
                        self.userLevelTextField.text = userMClub
                        
                        self.userLevelTextField.hidden = true
                        
                        self.userLevelTextField.hidden = true
                        
                        /*
                        ==========================================================================================
                        Load Contact Informations - Clube
                        ==========================================================================================
                        */
                        
                        var userMobile = object["cCelular"] as? String
                        self.userLevelTextField.text = userMobile
                        
                        var userFBLPage = object["cFB"] as? String
                        self.userLevelTextField.text = userFBLPage
                        
                        var userTWLinkPage = object["cTwitter"] as? String
                        self.userLevelTextField.text = userTWLinkPage
                        
                        var userLNLPage = object["cLinkedIn"] as? String
                        self.userLevelTextField.text = userLNLPage
                        
                        var userMPro = object["cEmailPro"] as? String
                        self.userLevelTextField.text = userMPro
                        
                        /*
                        ==========================================================================================
                        Load Link Info - Clube
                        ==========================================================================================
                        */
                        
                        self.userLevelTextField.hidden = true
                        
                        self.userLevelTextField.hidden = true
                        
                        self.userLevelTextField.hidden = true
                        
                        self.userLevelTextField.hidden = true
                        
                    }
                }
            }
            
            /*
            ==========================================================================================
            Load Picture User - Clube
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
        
        let user:PFUser = PFUser.currentUser()!
        
        let userProfileType = PFUser.currentUser()?.objectForKey("profile_type") as? String
        
        
        /*
        ==========================================================================================
        Verify Profile Type and Load Info - Jogador
        ==========================================================================================
        */
        
        if userProfileType == "Jogador"{
            
            let user:PFUser = PFUser.currentUser()!
            
            println(user.objectId)
            
            let userID = user.objectId
            
            // Create the Player query
            
            var playerQuery = PFQuery(className:"UserPlayer")
            
            
            // Constrain the query to the current user
            
            playerQuery.whereKey("playerKey", equalTo: PFUser.currentUser()!)
            
            
            playerQuery.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                if (error == nil) {
                    if let playerArray = objects as? [PFObject] {
                        for player in playerArray {
                            // Do something with the player object
                            // If you modify the object, save it asynchronously when done
                            
                            /*
                            ==========================================================================================
                            Save Personal Info - Jogador
                            ==========================================================================================
                            */
                            player["first_name"] = self.userFNameTextField.text
                            player["last_name"] = self.userLNameTextField.text
                            player["pCPF"] = self.CPFTextField.text
                            player["pApelido"] = self.apelidoTextField.text
                            player["pGenero"] = self.generoTextField.text
                            player["pNascimento"] = self.nascDataTextField.text
                            player["pNacionalidade"] = self.nacionalidadeTextField.text
                            player["pEndereco"] = self.addressTextField.text
                            player["pCidade"] = self.addressTextField.text
                            player["pEstado"] = self.addressTextField.text
                            
                            /*
                            ==========================================================================================
                            Save Professional Info - Jogador
                            ==========================================================================================
                            */
                            
                            player["pModalidade"] = self.userModalTextField.text
                            player["pKickfoot"] = self.userKickFootTextField.text
                            player["pAltura"] = self.userHightTextField.text
                            player["pPeso"] = self.userWeightTextField.text
                            player["pNumfoot"] = self.userNumFootTextField.text
                            player["pPosicao"] = self.userPositionTextField.text
                            player["pNivel"] = self.userLevelTextField.text
                            
                            /*
                            ==========================================================================================
                            Save Plus Informations - Jogador
                            ==========================================================================================
                            */
                            
                            player["pPrefMarcas"] = self.userLevelTextField.text
                            player["pEscolaridade"] = self.userLevelTextField.text
                            player["pClube"] = self.userLevelTextField.text
                            player["pFederado"] = self.userLevelTextField.text
                            player["pDreamTeam"] = self.userLevelTextField.text
                            
                            /*
                            ==========================================================================================
                            Load Contact Informations - Jogador
                            ==========================================================================================
                            */
                            
                            player["pCelular"] = self.userLevelTextField.text
                            player["pFB"] = self.userLevelTextField.text
                            player["pTwitter"] = self.userLevelTextField.text
                            player["pLinkedIn"] = self.userLevelTextField.text
                            player["pEmailPro"] = self.userLevelTextField.text
                            
                            /*
                            ==========================================================================================
                            Load Link Info - Jogador
                            ==========================================================================================
                            */
                            
                            player["pLink1"] = self.userLevelTextField.text
                            player["pLink2"] = self.userLevelTextField.text
                            player["pLink3"] = self.userLevelTextField.text
                            player["pLink4"] = self.userLevelTextField.text
                            
                            
                            player.saveInBackground()
                            
                            /*
                            ==========================================================================================
                            Load Picture User - Jogador
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
                    }
                } else {
                    // Log the details of the failure
                    
                    println("query error: \(error) \(error!.userInfo!)")
                    
                }
            }
            
        }
        
        
        /*
        ==========================================================================================
        Verify Profile Type and Load Info - Empresario
        ==========================================================================================
        */
        if userProfileType == "Empresario"{
            
            //let sameuser:PFObject = PFObject(className: "UserPlayer")
            
            var query = PFQuery(className:"UserEmpresario")
            query.includeKey("empKey")
            query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                
                
                if let objects = objects as? [PFObject]{
                    
                    for object in objects {
                        
                      //Arrumar
                        
                    }
                }
            }
            
            /*
            ==========================================================================================
            Load Picture User - Empresario
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
        
        
        
        
        /*
        ==========================================================================================
        Verify Profile Type and Load Info - Clube
        ==========================================================================================
        */
        if userProfileType == "Clube"{
            
            //let sameuser:PFObject = PFObject(className: "UserPlayer")
            
            var query = PFQuery(className:"UserClube")
            query.includeKey("clubeKey")
            query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                
                
                if let objects = objects as? [PFObject]{
                    
                    for object in objects {
                        
                        // Arrumar
                        
                    }
                }
            }
            
            /*
            ==========================================================================================
            Load Picture User - Clube
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
