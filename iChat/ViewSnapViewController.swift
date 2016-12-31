//
//  ViewSnapViewController.swift
//  iChat
//
//  Created by Cappillen on 12/30/16.
//  Copyright © 2016 Cappillen. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = snap.descript
        
        imageView.sd_setImage(with: URL(string: snap.imageURL))
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("Goodbye")
        FIRDatabase.database().reference().child("users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").child(snap.key).removeValue()
        
            FIRStorage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
                print("we deleted the pic")
        }
    }

}
