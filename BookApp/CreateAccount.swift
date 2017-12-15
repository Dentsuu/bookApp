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
    @IBOutlet weak var createBtn: UIButton!
    
    @IBAction func createNewUser(_ sender: UIButton) {
        
        userCreate()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameInput.delegate = self
        emailInput.delegate = self
        passwordInput.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case usernameInput:
            usernameInput.resignFirstResponder()
            emailInput.becomeFirstResponder()
            break
        case emailInput:
            emailInput.resignFirstResponder()
            passwordInput.becomeFirstResponder()
            break
        case passwordInput:
            break
        default:
            break
        }
        return true
    }
    
    // ** Create new user in firebase
    @objc func userCreate() {
        
        guard let username = usernameInput.text else { return }
        guard let email = emailInput.text else { return }
        guard let pass = passwordInput.text else { return }
        
        // ** Create user with email & password
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                print("User Created")
                
                // ** Save the username in firebase
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges { error in
                    if error == nil {
                        print("User display name changed")
                        self.dismiss(animated: false, completion: nil)
                    }
                }
                
                self.performSegue(withIdentifier: "createdUser", sender: self)
                
            } else {
                print("Error creating user")
            }
        }
    }
    
    // ** Hide keyboard when pressing anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //This will hide the keyboard
    }
}














