//
//  LoginViewController.swift
//  Resonance
//
//  Created by Zach Terrell on 10/18/21.
//  Copyright © 2021 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController{
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
    }
    
//    func signInButton() {
//        guard let email = emailField.text else { return}
//        guard let password = passwordField.text else { return}
//
//        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {result, error in
//            print("signed in")
//        })
//    }
//
//    func createAccountButton() {
//        guard let email = emailField.text else { return}
//        guard let password = passwordField.text else { return}
//
//        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
//            if error == nil{
//                let createdUser = result?.user
//                print("account created")
//                self.ref.child("users").child(createdUser!.uid).child("email").setValue(createdUser?.email)
//            }
//            else{
//                print(error)
//            }
//        })
//    }
}
