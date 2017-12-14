//
//  StartView.swift
//  BookApp
//
//  Created by Petri Määttä on 2017-12-14.
//  Copyright © 2017 Petri Määttä. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.passwordInput.delegate = self;
        
    }
    
    
    
}
