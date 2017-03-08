//
//  PicturesViewController.swift
//  
//
//  Created by Cappillen on 12/27/16.
//
//

import UIKit
import Firebase

class PicturesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var funFactText: UILabel!
    
    var imagePicker = UIImagePickerController()
    
    var uuid = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        imagePicker.delegate = self
        nextButton.isEnabled = false
        
        let hi = Arrays()
        let x = arc4random_uniform(115)
        
        //check # of fun facts
        for i in 0...115 {
            print(hi.funArrays[i])
        }
        
        funFactText.adjustsFontSizeToFitWidth = true
        funFactText.text = hi.funArrays[Int(x)]
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        
        imageView.backgroundColor = UIColor.clear
        
        nextButton.isEnabled = true
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .camera
        
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        nextButton.isEnabled = false
        
        let imagesFolder =
            FIRStorage.storage().reference().child("images")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        
        imagesFolder.child("\(uuid).jpg").put(imageData, metadata: nil, completion: {(metadata, error) in
            print("We tried to upload")
            
            if error != nil {
                
                print("We hand an error:\(error)")
                
            } else {
                
                print(metadata?.downloadURL())
                
                self.performSegue(withIdentifier: "selectUserSegue", sender: metadata?.downloadURL()!.absoluteString)
            }
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    let nextVC = segue.destination as! SelectUserViewController
    nextVC.imageURL = sender as! String
    nextVC.descript = descriptionTextField.text!
    nextVC.uuid = uuid
        
    }
    
}
