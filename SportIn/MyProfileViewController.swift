//
//  MyProfileViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/24/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//?

import UIKit
import Parse

class MyProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var userFNameLabel: UILabel!
    @IBOutlet weak var userLNameLabel: UILabel!
    @IBOutlet weak var generoLabel: UILabel!
    @IBOutlet weak var nacionalidadeLabel: UILabel!
    @IBOutlet weak var CPFLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var userModalLabel: UILabel!
    @IBOutlet weak var userKickFootLabel: UILabel!
    @IBOutlet weak var userHightLabel: UILabel!
    @IBOutlet weak var userWeightLabel: UILabel!
    @IBOutlet weak var imcCalcLabel: UILabel!
    @IBOutlet weak var userNumFootLabel: UILabel!
    @IBOutlet weak var userPositionLabel: UILabel!
    @IBOutlet weak var userLevelLabel: UILabel!
    @IBOutlet weak var userPrefBrandsLabel: UILabel!
    @IBOutlet weak var userGradeLabel: UILabel!
    @IBOutlet weak var userMemberClubLabel: UILabel!
    @IBOutlet weak var userFederatedLabel: UILabel!
    @IBOutlet weak var userTeamDreamLabel: UILabel!
    @IBOutlet weak var userCellPhoneLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // codigo para personalizar o navigationBar
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        loadUserDetails()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuButton(sender: AnyObject) {
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }

    //Load user Details
    func loadUserDetails() {
        
        let user:PFUser = PFUser.currentUser()!
        
        let userProfileType = PFUser.currentUser()?.objectForKey("profile_type") as? String
        
        if userProfileType == "Jogador"{
            
            let sameuser:PFObject = PFObject(className: "UserPlayer")
            
            var query1 = PFQuery(className:"UserPlayer")
            query1.includeKey("playerKey")
            query1.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        var userFirstName = object["first_name"]  as! String
                        
                        var userLastName =  object["last_name"]  as! String
                        
                        self.userFNameLabel.text = "Nome: " + userFirstName
                        self.userLNameLabel.text = "Sobrenome: " + userLastName
                        
                    }
                }
            }
            
            
        }
        
        if userProfileType == "Empresario"{
            
            let sameuser:PFObject = PFObject(className: "UserEmpresario")
            
            var query1 = PFQuery(className:"UserEmpresario")
            query1.includeKey("empKey")
            query1.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        var userFirstName = object["first_name"]  as! String
                        
                        var userLastName =  object["last_name"]  as! String
                        
                        self.userFNameLabel.text = "Nome: " + userFirstName
                        self.userLNameLabel.text = "Sobrenome: " + userLastName
                        
                        self.userKickFootLabel.hidden = true
                        self.userHightLabel.hidden = true
                        self.userWeightLabel.hidden = true
                        self.imcCalcLabel.hidden = true
                        self.userNumFootLabel.hidden = true
                        self.userPositionLabel.hidden = true
                        self.userLevelLabel.hidden = true

                    }
                }
            }
            
            
        }
        
        if userProfileType == "Clube"{
            
            let sameuser:PFObject = PFObject(className: "UserClube")
            
            var query1 = PFQuery(className:"UserEmpresario")
            query1.includeKey("clubeKey")
            query1.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        var userFirstName = object["first_name"]  as! String
                        
                        var userLastName =  object["last_name"]  as! String
                        
                        self.userFNameLabel.text = "Nome: " + userFirstName
                        self.userLNameLabel.text = "Sobrenome: " + userLastName
                        
                    }
                }
            }
            
            
        }
      
        
       
       
        
        //let userFName = PFUser.currentUser()?.objectForKey("first_name") as? String
        //let userLName = PFUser.currentUser()?.objectForKey("last_name") as? String
        
        
        //let myUserPlayer = PFObject(className: "UserPlayer")
        
        /*
        let userEmail = PFUser.currentUser()?.objectForKey("first_name") as? String
        let userCPF = PFUser.currentUser()?.objectForKey("user_CPF") as? String
        let userAddress = PFUser.currentUser()?.objectForKey("user_address") as? String
        let userApelido = PFUser.currentUser()?.objectForKey("user_apelido") as? String
        let userBirth = PFUser.currentUser()?.objectForKey("user_birth") as? String
        let userGen = PFUser.currentUser()?.objectForKey("user_gen") as? String
        let userNationality = PFUser.currentUser()?.objectForKey("user_natio") as? String
        let userMod = PFUser.currentUser()?.objectForKey("user_modal") as? String
        let userKFoot = PFUser.currentUser()?.objectForKey("user_kickfoot") as? String
        let userHth = PFUser.currentUser()?.objectForKey("user_height") as? String
        let userWth = PFUser.currentUser()?.objectForKey("user_weight") as? String
        let userNmFoot = PFUser.currentUser()?.objectForKey("user_numfoot") as? String
        let userPos = PFUser.currentUser()?.objectForKey("user_position") as? String
        let userLvl = PFUser.currentUser()?.objectForKey("user_level") as? String
        let userSchool = PFUser.currentUser()?.objectForKey("user_grade") as? String
        let userMClub = PFUser.currentUser()?.objectForKey("user_menberclub") as? String
        let userDream = PFUser.currentUser()?.objectForKey("user_teamdream") as? String
        let userPrefBrands = PFUser.currentUser()?.objectForKey("user_prefbrands") as? String
        let userBrands = PFUser.currentUser()?.objectForKey("user_prefbrands") as? String
        let userFed = PFUser.currentUser()?.objectForKey("user_federated") as? String
        let userMobile = PFUser.currentUser()?.objectForKey("user_cellphone") as? String
        */
        
        /*
       
        generoLabel.text = "Genero: " + userGen!
        nacionalidadeLabel.text = "Nascionalidade: " + userNationality!
        CPFLabel.text = "Meu Cpf: " + userCPF!
        addressLabel.text = "Endereço: " + userAddress!
        userModalLabel.text = "Minha modalidade: " + userMod!
        userKickFootLabel.text = "Perna que chuto: " + userKFoot!
        userHightLabel.text = "Minha altura: " + userHth! + "cm"
        userWeightLabel.text = "Meu peso atual: " + userWth! + "Kg"
        userNumFootLabel.text = "Meu No de calçado: " + userNmFoot!
        userPositionLabel.text = "Posição que jogo melhor: " + userPos!
        userLevelLabel.text = "Meu nivel é: " + userLvl!
        userGradeLabel.text = "Minha escolaridade: " + userSchool!
        userMemberClubLabel.text = "Já sou membrod e um CLube? : " + userMClub!
        userTeamDreamLabel.text = "Time que eu sonho em jogar: " + userDream!
        userPrefBrandsLabel.text = "Minha marca preferida é: " + userPrefBrands!
        userFederatedLabel.text = "Já sou federado? : " + userFed!
        userCellPhoneLabel.text = "Meu celeular: " + userMobile!
        
        */
        let profilePictureObject = PFUser.currentUser()?.objectForKey("profile_picture") as? PFFile
        
        profilePictureObject!.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
            
            if(imageData != nil)
            {
                self.userProfilePicture.image = UIImage(data: imageData!)
            }
            
        }


    }
    
    @IBAction func editProfileButton(sender: AnyObject) {
        var editProfile = self.storyboard?.instantiateViewControllerWithIdentifier("EditProfileViewController") as! EditProfileViewController
        //editProfile.opener = self
        
        let editProfileNav = UINavigationController(rootViewController: editProfile)
        
        self.presentViewController(editProfileNav, animated: true, completion: nil)
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
