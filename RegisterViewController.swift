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
        
       /* let myUserPlayer = PFObject(className: "UserPlayer")
            myUserPlayer["playerKey"] = ""
            myUserPlayer.saveInBackground()
           */
        let myUser:PFUser = PFUser()
        myUser.username = userEmail
        myUser.password = userPassword
        myUser.email = userEmail
        myUser.setObject(userCPF, forKey: "user_CPF")
        myUser.setObject(selectedProfile, forKey: "profile_type")
       
        
            /*
            // Set Basic infos
            myUserPlayer.setObject(userFirstName, forKey: "first_name")
            myUserPlayer.setObject(userLastName, forKey: "last_name")
            myUserPlayer.setObject(userEmail, forKey: "username")
            
       
            */
            // Set new values for Personal Info
            //myUserPlayer.setObject(userCPF, forKey: "pCPF")
            /*myUserPlayer.setObject("", forKey: "pNascimento")
            myUserPlayer.setObject("", forKey: "pApelido")
            myUserPlayer.setObject("", forKey: "pGenero")
            myUserPlayer.setObject("", forKey: "pNacionalidade")
            myUserPlayer.setObject("", forKey: "pEndereço")
            
            // Set new values for Pro Info
            myUserPlayer.setObject("", forKey: "pModalidade")
            myUserPlayer.setObject("", forKey: "pPernaChuta")
            myUserPlayer.setObject("", forKey: "pAltura")
            myUserPlayer.setObject("", forKey: "pPeso")
            myUserPlayer.setObject("", forKey: "pNumeroCalcado")
            myUserPlayer.setObject("", forKey: "pPosicao")
            myUserPlayer.setObject("", forKey: "pLevel")
            
            // Set new values for Pro Info
            myUserPlayer.setObject("", forKey: "pLinkUm")
            myUserPlayer.setObject("", forKey: "pLinkDois")
            myUserPlayer.setObject("", forKey: "pLinkTres")
            myUserPlayer.setObject("", forKey: "pLinkQuatro")
            
            // Set new values for Pro Info
            myUserPlayer.setObject("", forKey: "pEscolaridade")
            myUserPlayer.setObject("", forKey: "pMembroClube")
            myUserPlayer.setObject("", forKey: "pTimeSonho")
            myUserPlayer.setObject("", forKey: "pPrefrenciaMarcas")
            myUserPlayer.setObject("", forKey: "pFederado")
            
            // Set new values for Pro Info
            myUserPlayer.setObject("", forKey: "pEmailPro")
            myUserPlayer.setObject("", forKey: "pFBpage")
            myUserPlayer.setObject("", forKey: "pLinkedpage")
            myUserPlayer.setObject("", forKey: "pTwitterpage")
            myUserPlayer.setObject("", forKey: "pCellphone")
            */
            //let gameQuery = PFQuery(className:"UserPlayer")
            //if let user = PFUser.currentUser() {
            //    gameQuery.whereKey("playerKey", equalTo: user)
            //}
            
            //let myUserPlayer = PFObject(className: "UserPlayer")
            
            //set blank info for evoid conflict in MyProfile Access
            
            
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
        
        
            // Indicador que inicia o metodo de gravar no banco de dados
        
        myUser.signUpInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            
            //myUserPlayer.saveInBackground()
            
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
                    
                    // Set Basic infos
                    myUserPlayer.setObject(userFirstName, forKey: "first_name")
                    myUserPlayer.setObject(userLastName, forKey: "last_name")
                    myUserPlayer.setObject(userEmail, forKey: "username")
                    
                    // Set new values for Personal Info
                    myUserPlayer.setObject(userCPF, forKey: "pCPF")
                    //myUserPlayer.setObject(userID, forKey: "playerKey")
                    myUserPlayer["playerKey"] = PFUser.objectWithoutDataWithObjectId(userID)
                    
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
            myUser.setObject(selectedProfile, forKey: "profile_type")
            
            //var query = PFQuery(className:"User")
            //query.getObjectInBackgroundWithId("xWMyZEGZ")
            
            let myUserEmpresario:PFObject = PFObject(className: "UserEmpresario")
            myUserEmpresario["test"] = "teste"
            myUserEmpresario.setObject(userFirstName, forKey: "first_name")
            myUserEmpresario.setObject(userLastName, forKey: "last_name")
            myUserEmpresario.setObject(userCPF, forKey: "user_CPF")
            myUserEmpresario.setObject(selectedProfile, forKey: "keyUser")
            
            //myUserEmpresario.saveInBackground()
            
            
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
             //myUserEmpresario.saveInBackground()
                
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
            myUser.setObject(selectedProfile, forKey: "profile_type")
            
            let myUserClube:PFObject = PFObject(className: "UserClube")
            myUserClube["test"] = "teste"
            myUserClube.setObject(userFirstName, forKey: "first_name")
            myUserClube.setObject(userLastName, forKey: "last_name")
            myUserClube.setObject(userCPF, forKey: "user_CPF")
            myUserClube.setObject(selectedProfile, forKey: "keyUser")
            
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
