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
    @IBOutlet weak var userProfileType: UILabel!
    @IBOutlet weak var userFNameLabel: UILabel!
    @IBOutlet weak var userLNameLabel: UILabel!
    @IBOutlet weak var userNickN: UILabel!
    @IBOutlet weak var generoLabel: UILabel!
    @IBOutlet weak var nacionalidadeLabel: UILabel!
    @IBOutlet weak var CPFLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
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
                        
                        var userType = object["profile_type"]  as! String
                        var userFirstName = object["first_name"]  as! String
                        var userLastName =  object["last_name"]  as! String
                        var userCPF =  object["pCPF"]  as! String
                        var userNickName =  object["pApelido"]  as! String
                        var userGen =  object["pGenero"]  as! String
                        var userNationality =  object["pNacionalidade"]  as! String
                        var userAddress =  object["pEndereco"]  as! String
                        var userCity =  object["pCidade"]  as! String
                        var userState =  object["pEstado"]  as! String
                        var userMod =  object["pModalidade"]  as! String
                        var userKFoot =  object["pKickfoot"]  as! String
                        var userHth =  object["pAltura"]  as! String
                        var userWth =  object["pPeso"]  as! String
                        var userNmFoot =  object["pNumfoot"]  as! String
                        var userPos =  object["pPosicao"]  as! String
                        var userLvl =  object["pNivel"]  as! String
                        var userPrefBrands =  object["pPrefMarcas"]  as! String
                        var userSchool =  object["pEscolaridade"]  as! String
                        var userMClub =  object["pClube"]  as! String
                        var userFed =  object["pFederado"]  as! String
                        var userDream =  object["pDreamTeam"]  as! String
                        var userMobile =  object["pCelular"]  as! String
                        
                        self.userProfileType.text = "T-User" + userType
                        self.userFNameLabel.text = "Nome: " + userFirstName
                        self.userLNameLabel.text = "Sobrenome: " + userLastName
                        self.CPFLabel.text = "Meu Cpf: " + userCPF
                        self.userNickN.text = "Apelido: " + userNickName
                        self.generoLabel.text = "Genero: " + userGen
                        self.nacionalidadeLabel.text = "Nascionalidade: " + userNationality
                        self.addressLabel.text = "Endereço: " + userAddress
                        self.cityLabel.text = "Cidade: " + userCity
                        self.stateLabel.text = "Estado: " + userState
                        self.userModalLabel.text = "Minha modalidade: " + userMod
                        self.userKickFootLabel.text = "Perna que chuto: " + userKFoot
                        self.userHightLabel.text = "Minha altura: " + userHth + "cm"
                        self.userWeightLabel.text = "Meu peso atual: " + userWth + "Kg"
                        self.userNumFootLabel.text = "Meu No de calçado: " + userNmFoot
                        self.userPositionLabel.text = "Posição que jogo melhor: " + userPos
                        self.userLevelLabel.text = "Meu nivel é: " + userLvl
                        self.userPrefBrandsLabel.text = "Minha marca preferida é: " + userPrefBrands
                        self.userGradeLabel.text = "Minha escolaridade: " + userSchool
                        self.userMemberClubLabel.text = "Já sou membrod e um CLube? : " + userMClub
                        self.userFederatedLabel.text = "Já sou federado? : " + userFed
                        self.userTeamDreamLabel.text = "Time que eu sonho em jogar: " + userDream
                        self.userCellPhoneLabel.text = "Meu celeular: " + userMobile
                        
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
                        
                        var userType = object["profile_type"]  as! String
                        var userFirstName = object["first_name"]  as! String
                        var userLastName =  object["last_name"]  as! String
                        var userCPF =  object["eCPF"]  as! String
                        var userNickName =  object["eApelido"]  as! String
                        var userGen =  object["eGenero"]  as! String
                        var userNationality =  object["eNacionalidade"]  as! String
                        var userAddress =  object["eEndereco"]  as! String
                        var userCity =  object["eCidade"]  as! String
                        var userState =  object["eEstado"]  as! String
                        var userMod =  object["eModalidade"]  as! String
                        //var userKFoot =  object["eKickfoot"]  as! String
                        //var userHth =  object["eAltura"]  as! String
                        //var userWth =  object["ePeso"]  as! String
                        //var userNmFoot =  object["eNumfoot"]  as! String
                        //var userPos =  object["ePosicao"]  as! String
                        var userLvl =  object["eNivel"]  as! String
                        var userPrefBrands =  object["ePrefMarcas"]  as! String
                        var userSchool =  object["eEscolaridade"]  as! String
                        var userMClub =  object["eClube"]  as! String
                        var userFed =  object["eFederado"]  as! String
                        //var userDream =  object["eDreamTeam"]  as! String
                        var userMobile =  object["eCelular"]  as! String
                        
                        self.userProfileType.text = userType
                        self.userFNameLabel.text = "Nome: " + userFirstName
                        self.userLNameLabel.text = "Sobrenome: " + userLastName
                        self.CPFLabel.text = "Meu Cpf: " + userCPF
                        self.userNickN.text = "Apelido: " + userNickName
                        self.generoLabel.text = "Genero: " + userGen
                        self.nacionalidadeLabel.text = "Nascionalidade: " + userNationality
                        self.addressLabel.text = "Endereço: " + userAddress
                        self.cityLabel.text = "Cidade: " + userCity
                        self.stateLabel.text = "Estado: " + userState
                        self.userModalLabel.text = "Minha modalidade: " + userMod
                        self.userKickFootLabel.hidden = true
                        self.userHightLabel.hidden = true
                        self.userWeightLabel.hidden = true
                        self.userNumFootLabel.hidden = true
                        self.userPositionLabel.hidden = true
                        self.userLevelLabel.text = "Meu nivel é: " + userLvl
                        self.userPrefBrandsLabel.text = "Minha marca preferida é: " + userPrefBrands
                        self.userGradeLabel.text = "Minha escolaridade: " + userSchool
                        self.userMemberClubLabel.text = "Já sou membrod e um CLube? : " + userMClub
                        self.userFederatedLabel.text = "Já sou federado? : " + userFed
                        self.userTeamDreamLabel.hidden = true
                        self.userCellPhoneLabel.text = "Meu celeular: " + userMobile
                        
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
                        
                        var userType = object["profile_type"]  as! String
                        var userFirstName = object["first_name"]  as! String
                        var userLastName =  object["last_name"]  as! String
                        var userCPF =  object["cCPF"]  as! String
                        //var userNickName =  object["eApelido"]  as! String
                        var userGen =  object["cGenero"]  as! String
                        var userNationality =  object["cNacionalidade"]  as! String
                        var userAddress =  object["cEndereco"]  as! String
                        var userCity =  object["cCidade"]  as! String
                        var userState =  object["cEstado"]  as! String
                        var userMod =  object["cModalidade"]  as! String
                        //var userKFoot =  object["cKickfoot"]  as! String
                        //var userHth =  object["cAltura"]  as! String
                        //var userWth =  object["cPeso"]  as! String
                        //var userNmFoot =  object["cNumfoot"]  as! String
                        //var userPos =  object["cPosicao"]  as! String
                        //var userLvl =  object["cNivel"]  as! String
                        //var userPrefBrands =  object["cPrefMarcas"]  as! String
                        //var userSchool =  object["cEscolaridade"]  as! String
                        var userMClub =  object["cClube"]  as! String
                        //var userFed =  object["cFederado"]  as! String
                        //var userDream =  object["cDreamTeam"]  as! String
                        var userMobile =  object["cCelular"]  as! String
                        
                        self.userProfileType.text = "Tipo de usuario: " + userType
                        self.userFNameLabel.text = "Nome: " + userFirstName
                        self.userLNameLabel.text = "Sobrenome: " + userLastName
                        self.CPFLabel.text = "Meu Cpf: " + userCPF
                        self.userNickN.hidden = true
                        self.generoLabel.text = "Genero: " + userGen
                        self.nacionalidadeLabel.text = "Nascionalidade: " + userNationality
                        self.addressLabel.text = "Endereço: " + userAddress
                        self.cityLabel.text = "Cidade: " + userCity
                        self.stateLabel.text = "Estado: " + userState
                        self.userModalLabel.text = "Minha modalidade: " + userMod
                        self.userKickFootLabel.hidden = true
                        self.userHightLabel.hidden = true
                        self.userWeightLabel.hidden = true
                        self.userNumFootLabel.hidden = true
                        self.userPositionLabel.hidden = true
                        self.userLevelLabel.hidden = true
                        self.userPrefBrandsLabel.hidden = true
                        self.userGradeLabel.hidden = true
                        self.userMemberClubLabel.text = "Já sou membrod e um CLube? : " + userMClub
                        self.userFederatedLabel.hidden = true
                        self.userTeamDreamLabel.hidden = true
                        self.userCellPhoneLabel.text = "Meu celeular: " + userMobile
                        
                    }
                }
            }
            
            
        }
      
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
