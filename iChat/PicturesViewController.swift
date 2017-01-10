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

        imagePicker.delegate = self
        nextButton.isEnabled = false
        
        let x = arc4random_uniform(40)
        let hi = ["It is impossible to lick your elbow", "A crocodile can't stick its tongue out", "A shrimp's heart is in it's head", "You sneeze because your heart stops for a milisecond", "Ostriches don't never their heads in the ground", "Pigs can't look up into the sky", "A pregnant goldfish is called a twit", "Rats and horses can't vomit", "If you sneeze too hard you can fracture a rib", "The cigarette lighter was invented before the match", "A ducks quak doesn't echo", "In your lifetime you can eat 80 bugs, while sleeping", "Most lipstick contains fishscales", "Everyones tongue print is different", "A crocodile can't move its tongue or chew", "Crocodle's digestive juices are so strong it can digest a steel nail", "Hot water is heavier than cold", "On average, half of all teeth have some form of radioactivity", "Deer can't eat hay", "Geinea pigs and rabbits can't sweat", "Sloths take two weeks to digest their food", "Seals used for their fur get extremely sick when taken aboard ships", "Human birth control pills work on gorillas", "Lifespan of a squirrel is about nine years", "Gorillas sleep about 14 hours a day", "There are more than 50 different kinds of kangaroos", "Female Lion does 90% of the hunting", "Leonardo Da Vinci invented scisscors", "Human thigh bones are stronger concrete", "You can't kill yourself by holding your breath", "There is a city called Rome on every continent", "It's against the law to have a pet dog in Iceland", /**/"You're heart beats over 100,000 times a day", "A cats urine glows under a black light", "Humans and dolphines are the only species that have sex for pleasure", "Some lions mate over fifty times a day", "Butterflies taste with their feet", "Starfish have no brains", "A pigs orgasm can last 30 minutes", "An ostrich's eye is bigger than it's brain", "Slugs have four noses", "Dolphins sleep with one eye open", "Earth is the only planet not named after a god"]
        funFactText.adjustsFontSizeToFitWidth = true
        funFactText.text = hi[Int(x)]
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
