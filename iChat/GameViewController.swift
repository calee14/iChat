//
//  GameViewController.swift
//  iChat
//
//  Created by Cappillen on 1/9/17.
//  Copyright © 2017 Cappillen. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var storyText: UILabel!
    
    @IBOutlet weak var button1Text: UIButton!
    @IBOutlet weak var button2Text: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        self.button1Text.titleLabel?.adjustsFontSizeToFitWidth = true
        self.button2Text.titleLabel?.adjustsFontSizeToFitWidth = true
        
        storyText.adjustsFontSizeToFitWidth = true
        
        button1Text.setTitle("fly", for: .normal)
        button2Text.setTitle("a;lsdkjfl;asjdfa;sldfjsdjlf;kj", for: .normal)
        
    }
   
    @IBAction func button1Answer(_ sender: Any) {
    }
    
    @IBAction func button2Answer(_ sender: Any) {
    }
    


}
