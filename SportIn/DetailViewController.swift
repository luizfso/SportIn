//
//  DetailViewController.swift
//  
//
//  Created by Luiz Fernando Santiago on 9/22/15.
//
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // User selected object
    var currentObject : PFObject?
    
    // Object to update
    var updateObject : PFObject?
    
    // Image Picker object
    var imagePicker = UIImagePickerController()
    var imageDidChange = false
    
    // Some text fields
    
    @IBOutlet weak var nomeCompleto: UILabel!
    @IBOutlet weak var userContato: UILabel!
    @IBOutlet weak var userNivel: UILabel!
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var idadeUser: UILabel!
    @IBOutlet weak var linkVideo: UILabel!
    @IBOutlet weak var modalidade: UILabel!
    @IBOutlet weak var userFoto: UIImageView!
    
    // The save button
    
    @IBAction func saveButton(sender: AnyObject) {
        
        // Use the sent country object or create a new country PFObject
        if let updateObjectTest = currentObject as PFObject? {
            updateObject = currentObject! as PFObject
        } else {
            updateObject = PFObject(className:"UserPlayer")
        }
        
         //Update the object
        if let updateObject = updateObject {
            
            updateObject["first_name"] = nomeCompleto.text
            updateObject["pNascimento"] = idadeUser.text
            updateObject["pModalidade"] = modalidade.text
            updateObject["nameEnglish"] = linkVideo.text
            updateObject["nameLocal"] = userType.text
            updateObject["capital"] = userNivel.text
            updateObject["currencyCode"] = userContato.text
            
            // Create a string of text that is used by search capabilites
            let searchText = (nomeCompleto.text! + " " + modalidade.text! + " " + userContato.text! + " " + userNivel.text! + " "  + idadeUser.text!)
            updateObject["searchText"] = searchText
            
            // Upload any flag image
            if imageDidChange == true {
                let imageData = UIImagePNGRepresentation(userFoto.image!)
                let fileName = nomeCompleto.text! + ".png"
                let imageFile = PFFile(name:fileName, data:imageData!)
                updateObject["flag"] = imageFile
            }
            
            // Update the record ACL such that the new record is only visible to the current user
            updateObject.ACL = PFACL(user: PFUser.currentUser()!)
            
            // Save the data back to the server in a background task
            updateObject.saveInBackground()
        }
        
        // Return to table view
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // Present image picker
    // Will prompt user to allow permission to device photo library
    
    @IBAction func uploadFlagImage(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .PhotoLibrary
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    
    // Process selected image - add image to the parse object model
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // Update the image within the app interface
            userFoto.image = pickedImage
            userFoto.contentMode = .ScaleAspectFit
            
            // Update the image did change flag so that we pick this up when the country is ssaved back to Parse
            imageDidChange = true
        }
        
        // Dismiss the image picker
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure delegate property for the form fields
        /*
        nomeCompleto.delegate = self
        userContato.delegate = self
        userNivel.delegate = self
        userType.delegate = self
        idadeUser.delegate = self
        linkVideo.delegate = self
        modalidade.delegate = self
        */
        
        
        // Unwrap the current object object
        if let object = currentObject {
            if let nome = object["first_name"] as? String {
                nomeCompleto.text = nome
            }
            if let contato = object["pCelular"] as? String {
                userContato.text = contato
            }
            if let nivel = object["pNivel"] as? String {
                userNivel.text = nivel
            }
            if let tipo = object["profile_type"] as? String {
                userType.text = tipo
            }
            if let idade = object["pNascimento"] as? String {
                idadeUser.text = idade
            }
            if let link = object["pLink1"] as? String {
                linkVideo.text = link
            }
            if let modal = object["pModalidade"] as? String {
                modalidade.text = modal
            }
            
            // Display standard question image
            //var initialThumbnail = UIImage(named: "question")
            //userFoto.image = initialThumbnail
            
            // Replace question image if an image exists on the parse platform
            if let thumbnail = object["profile_picture"] as? PFFile {
                thumbnail.getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
                    
                    if(imageData != nil)
                    {
                        self.userFoto.image = UIImage(data: imageData!)
                        self.userFoto.layer.cornerRadius = 78
                        self.userFoto.clipsToBounds = true
                        self.userFoto.layer.borderWidth = 1
                        self.userFoto.layer.borderColor = UIColor.blackColor().CGColor
                    }
              // userFoto.loadInBackground()
            }
            }
        }
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
