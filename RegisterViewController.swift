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

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIScrollViewDelegate {

    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userCPFText: UITextField!
    @IBOutlet weak var userPasswordText: UITextField!
    @IBOutlet weak var userPassVerifText: UITextField!
    @IBOutlet weak var userTypeSelected: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var perfilSelected: UILabel!
    
    
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
        
        switch row {
            
        case 0:
            println("Selecionar Meu Perfil")
            userTypeSelected.text = ""
            println("Nada Selecionado")
            
        case 1:
            println("Jogador Selecionado")
            let pickedProfile = userType[row]
            userTypeSelected.text = pickedProfile
            perfilSelected.text = pickedProfile
            self.pickerView.hidden = true
            
        case 2:
            println("Empresario Selecionado")
            let pickedProfile = userType[row]
            userTypeSelected.text = pickedProfile
            perfilSelected.text = pickedProfile
            self.pickerView.hidden = true
            
        case 3:
            println("Clube Selecionado")
            let pickedProfile = userType[row]
            userTypeSelected.text = pickedProfile
            perfilSelected.text = pickedProfile
            self.pickerView.hidden = true
            
        default:
            userTypeSelected.text = ""
            println("Nada Selecionado")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyborad")
        view.addGestureRecognizer(tap)
        //scrollView.delegate = self

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        profileImgView.layer.cornerRadius = 10 //profilePictureImageView.frame.size.width/3
        profileImgView.clipsToBounds = true
        
        self.pickerView.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func DismissKeyborad(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        userEmailTextField.resignFirstResponder()
        userFirstNameTextField.resignFirstResponder()
        userLastNameTextField.resignFirstResponder()
        userCPFText.resignFirstResponder()
        userPasswordText.resignFirstResponder()
        userPassVerifText.resignFirstResponder()
        
        return true
    }
    
    
    @IBAction func openPickerView(sender: AnyObject) {
        self.pickerView.hidden = false
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
            var myAlert = UIAlertController(title:"Alert", message:"Password não é o mesmo. Tente novamente", preferredStyle:UIAlertControllerStyle.Alert)
            
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
        
        let myUser:PFUser = PFUser()
        myUser.username = userEmail
        myUser.password = userPassword
        myUser.email = userEmail
        myUser.setObject(userCPF, forKey: "user_CPF")
        myUser.setObject(userFirstName, forKey: "first_name")
        myUser.setObject(userFirstName, forKey: "last_name")
        myUser.setObject(selectedProfile, forKey: "profile_type")
        
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
        
        // Indicador que inicia o metodo de gravar no banco de dados
        myUser.signUpInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in

            // Hide activity indicator
            spiningActivity.hide(true)
            
            var userMessage = "Registro efetuado com sucesso. Obrigado!"
            
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
                    
                    let user = PFUser.currentUser()
                    
                    println(user?.objectId)
                    
                    let userID = user!.objectId
                    
                    let myUserPlayer:PFObject = PFObject(className: "UserPlayer")
                    
                    // Set ID from User Table
                    myUserPlayer["playerKey"] = PFUser.objectWithoutDataWithObjectId(userID)
                    
                    // Set Basic infos
                    myUserPlayer.setObject(userEmail, forKey: "username")
                    myUserPlayer.setObject(selectedProfile, forKey: "profile_type")
                    myUserPlayer.setObject(userFirstName, forKey: "first_name")
                    myUserPlayer.setObject(userLastName, forKey: "last_name")
                    myUserPlayer.setObject(userCPF, forKey: "pCPF")
                    
                    // Set da imagem na Tabela Player
                    
                    if(PFUser.currentUser()?.objectForKey("profile_picture") != nil)
                    {
                        let userImageFile:PFFile = PFUser.currentUser()?.objectForKey("profile_picture") as! PFFile
                        
                        myUserPlayer.setObject(userImageFile, forKey: "profile_picture")
                        
                       
                    }
                    // Set informacoes em branco para evitar conflito de informacoes
                    // Set new values for Personal Info
                    myUserPlayer.setObject("", forKey: "pApelido")
                    myUserPlayer.setObject("", forKey: "pNascimento")
                    myUserPlayer.setObject("", forKey: "pNacionalidade")
                    myUserPlayer.setObject("", forKey: "pGenero")
                    myUserPlayer.setObject("", forKey: "pEndereco")
                    myUserPlayer.setObject("", forKey: "pCidade")
                    myUserPlayer.setObject("", forKey: "pEstado")
                    
                    // Set new values for Pro Info
                    myUserPlayer.setObject("", forKey: "pModalidade")
                    myUserPlayer.setObject("", forKey: "pKickfoot")
                    
                    myUserPlayer.setObject("", forKey: "pAltura")
                    myUserPlayer.setObject("", forKey: "pPeso")
                    myUserPlayer.setObject("", forKey: "pNumfoot")
                    myUserPlayer.setObject("", forKey: "pPosicao")
                    myUserPlayer.setObject("", forKey: "pNivel")
                    
                    
                    // Set new values for Pro Info
                    myUserPlayer.setObject("", forKey: "pPrefMarcas")
                    myUserPlayer.setObject("", forKey: "pEscolaridade")
                    myUserPlayer.setObject("", forKey: "pClube")
                    myUserPlayer.setObject("", forKey: "pFederado")
                    myUserPlayer.setObject("", forKey: "pDreamTeam")
                    myUserPlayer.setObject("", forKey: "pCelular")
                    
                    
                    // Set new values for Pro Info
                    myUserPlayer.setObject("", forKey: "pFB")
                    myUserPlayer.setObject("", forKey: "pTwitter")
                    myUserPlayer.setObject("", forKey: "pLinkedIn")
                    myUserPlayer.setObject("", forKey: "pEmailPro")
                    
                    // Set new values for Pro Info
                    myUserPlayer.setObject("", forKey: "pLink1")
                    myUserPlayer.setObject("", forKey: "pLink2")
                    myUserPlayer.setObject("", forKey: "pLink3")
                    myUserPlayer.setObject("", forKey: "pLink4")

                    // Salvando no BD
                    myUserPlayer.saveInBackground()
                    
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
            myUser.setObject(userCPF, forKey: "user_CPF")
            myUser.setObject(userFirstName, forKey: "first_name")
            myUser.setObject(userFirstName, forKey: "last_name")
            myUser.setObject(selectedProfile, forKey: "profile_type")
            
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
            
            // Indicador que inicia o metodo de gravar no banco de dados
            myUser.signUpInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
                
                // Hide activity indicator
                spiningActivity.hide(true)
                
                var userMessage = "Registro efetuado com sucesso. Obrigado!"
                
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
                        
                        let user = PFUser.currentUser()
                        
                        println(user?.objectId)
                        
                        let userID = user!.objectId
                        
                        let myUserEmpresario:PFObject = PFObject(className: "UserEmpresario")
                        
                        // Set ID from User Table
                        myUserEmpresario["empKey"] = PFUser.objectWithoutDataWithObjectId(userID)
                        
                        // Set Basic infos
                        myUserEmpresario.setObject(userEmail, forKey: "username")
                        myUserEmpresario.setObject(selectedProfile, forKey: "profile_type")
                        myUserEmpresario.setObject(userFirstName, forKey: "first_name")
                        myUserEmpresario.setObject(userLastName, forKey: "last_name")
                        myUserEmpresario.setObject(userCPF, forKey: "eCPF")
                        
                        // Set da imagem na Tabela Empresario
                        if(PFUser.currentUser()?.objectForKey("profile_picture") != nil)
                        {
                            let userImageFile:PFFile = PFUser.currentUser()?.objectForKey("profile_picture") as! PFFile
                            
                            myUserEmpresario.setObject(userImageFile, forKey: "profile_picture")
                            
                            
                        }
                        
                        // Set informacoes em branco para evitar conflito de informacoes
                        // Set new values for Personal Info
                        myUserEmpresario.setObject("", forKey: "eApelido")
                        myUserEmpresario.setObject("", forKey: "eNascimento")
                        myUserEmpresario.setObject("", forKey: "eNacionalidade")
                        myUserEmpresario.setObject("", forKey: "eGenero")
                        myUserEmpresario.setObject("", forKey: "eEndereco")
                        myUserEmpresario.setObject("", forKey: "eCidade")
                        myUserEmpresario.setObject("", forKey: "eEstado")
                        
                        // Set new values for Pro Info
                        myUserEmpresario.setObject("", forKey: "eCNPJ")
                        myUserEmpresario.setObject("", forKey: "eModalidade")
                        //myUserEmpresario.setObject("", forKey: "pKickfoot")
                        
                        //myUserEmpresario.setObject("", forKey: "pAltura")
                        //myUserEmpresario.setObject("", forKey: "pPeso")
                        //myUserEmpresario.setObject("", forKey: "pNumfoot")
                        //myUserEmpresario.setObject("", forKey: "pPosicao")
                        myUserEmpresario.setObject("", forKey: "eNivel")
                        
                        
                        // Set new values for Pro Info
                        myUserEmpresario.setObject("", forKey: "ePrefMarcas")
                        myUserEmpresario.setObject("", forKey: "eEscolaridade")
                        myUserEmpresario.setObject("", forKey: "eClube")
                        myUserEmpresario.setObject("", forKey: "eFederado")
                        //myUserEmpresario.setObject("", forKey: "pDreamTeam")
                        myUserEmpresario.setObject("", forKey: "eCelular")
                        
                        
                        // Set new values for Pro Info
                        myUserEmpresario.setObject("", forKey: "eFB")
                        myUserEmpresario.setObject("", forKey: "eTwitter")
                        myUserEmpresario.setObject("", forKey: "eLinkedIn")
                        myUserEmpresario.setObject("", forKey: "eEmailPro")
                        
                        // Set new values for Pro Info
                        //myUserEmpresario.setObject("", forKey: "pLink1")
                        //myUserEmpresario.setObject("", forKey: "pLink2")
                        //myUserEmpresario.setObject("", forKey: "pLink3")
                        //myUserEmpresario.setObject("", forKey: "pLink4")
                        
                        // Salvando no BD
                        myUserEmpresario.saveInBackground()
                        
                        
                    }
                    
                }
                
                myAlert.addAction(okAction)
                
                self.presentViewController(myAlert, animated: true, completion: nil)
                
            }
            
        }

        
        if(selectedProfile == "Clube")
        {
            
            let myUser:PFUser = PFUser()
            myUser.username = userEmail
            myUser.password = userPassword
            myUser.email = userEmail
            myUser.setObject(userCPF, forKey: "user_CPF")
            myUser.setObject(userFirstName, forKey: "first_name")
            myUser.setObject(userFirstName, forKey: "last_name")
            myUser.setObject(selectedProfile, forKey: "profile_type")
            
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
            
            // Indicador que inicia o metodo de gravar no banco de dados
            myUser.signUpInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
                
                // Hide activity indicator
                spiningActivity.hide(true)
                
                var userMessage = "Registro efetuado com sucesso. Obrigado!"
                
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
                        
                        let user = PFUser.currentUser()
                        
                        println(user?.objectId)
                        
                        let userID = user!.objectId
                        
                        let myUserClube:PFObject = PFObject(className: "UserClube")
                        
                        // Set ID from User Table
                        myUserClube["clubeKey"] = PFUser.objectWithoutDataWithObjectId(userID)
                        
                        // Set Basic infos
                        myUserClube.setObject(userEmail, forKey: "username")
                        myUserClube.setObject(selectedProfile, forKey: "profile_type")
                        myUserClube.setObject(userFirstName, forKey: "first_name")
                        myUserClube.setObject(userLastName, forKey: "last_name")
                        myUserClube.setObject(userCPF, forKey: "eCPF")
                        
                        if(PFUser.currentUser()?.objectForKey("profile_picture") != nil)
                        {
                            let userImageFile:PFFile = PFUser.currentUser()?.objectForKey("profile_picture") as! PFFile
                            
                            myUserClube.setObject(userImageFile, forKey: "profile_picture")
                            
                            
                        }
                        
                        // Set informacoes em branco para evitar conflito de informacoes
                        // Set new values for Personal Info
                        //myUserClube.setObject("", forKey: "pApelido")
                        myUserClube.setObject("", forKey: "pNascimento")
                        myUserClube.setObject("", forKey: "pNacionalidade")
                        myUserClube.setObject("", forKey: "pGenero")
                        myUserClube.setObject("", forKey: "pEndereco")
                        myUserClube.setObject("", forKey: "pCidade")
                        myUserClube.setObject("", forKey: "pEstado")
                        
                        // Set new values for Pro Info
                        myUserClube.setObject("", forKey: "pModalidade")
                        //myUserClube.setObject("", forKey: "pKickfoot")
                        
                        //myUserClube.setObject("", forKey: "pAltura")
                        //myUserClube.setObject("", forKey: "pPeso")
                        //myUserClube.setObject("", forKey: "pNumfoot")
                        //myUserClube.setObject("", forKey: "pPosicao")
                        //myUserClube.setObject("", forKey: "pNivel")
                        
                        
                        // Set new values for Pro Info
                        //myUserClube.setObject("", forKey: "pPrefMarcas")
                        //myUserClube.setObject("", forKey: "pEscolaridade")
                        myUserClube.setObject("", forKey: "pClube")
                        //myUserClube.setObject("", forKey: "pFederado")
                        //myUserClube.setObject("", forKey: "pDreamTeam")
                        myUserClube.setObject("", forKey: "pCelular")
                        
                        
                        // Set new values for Pro Info
                        myUserClube.setObject("", forKey: "pFB")
                        myUserClube.setObject("", forKey: "pTwitter")
                        myUserClube.setObject("", forKey: "pLinkedIn")
                        myUserClube.setObject("", forKey: "pEmailPro")
                        
                        // Set new values for Pro Info
                        //myUserClube.setObject("", forKey: "pLink1")
                        //myUserClube.setObject("", forKey: "pLink2")
                        //myUserClube.setObject("", forKey: "pLink3")
                        //myUserClube.setObject("", forKey: "pLink4")
                        
                        // Salvando no BD
                        myUserClube.saveInBackground()
                        
                        
                    }
                    
                }
                
                myAlert.addAction(okAction)
                
                self.presentViewController(myAlert, animated: true, completion: nil)
                
            }
            
        }
        
        
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
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
