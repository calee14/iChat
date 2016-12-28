//
//  SignInViewController.swift
//  iChat
//
//  Created by Cappillen on 12/11/16.
//  Copyright © 2016 Cappillen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func turnUpTapped(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion:
            { (user, error) in
            print("We tried to sign in")
                if (error != nil) {
                    print("Hey we have an error:\(error)")
                    
                    FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                        print("We tried to create a user.")
                        
                        if error != nil {
                            print("Hey we have an error: \(error)")
                        } else {
                            print("Created User Succesfully")
                            
                    FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email)
                            
                            self.performSegue(withIdentifier: "signinsegue", sender: nil)
                        }
                    })
                    
                } else {
                    print("Signed In Succesfully")
                    
                    self.performSegue(withIdentifier: "signinsegue", sender: nil)
                }
        })
    }
    


}

