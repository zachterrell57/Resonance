//
//  LoginViewController.swift
//  Resonance
//
//  Created by Zach Terrell on 10/18/21.
//  Copyright © 2021 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    var ref: DatabaseReference!
    
    let emailLabel = UILabel()
    let emailField = UITextField()
    let passwordLabel = UILabel()
    let passwordField = UITextField()
    let signInButton = UIButton(type: .system)
    let createAccountButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
       
        loadEmailField()
        loadPasswordField()
        
        loadPasswordLabel()
        loadEmailLabel()
        loadSignInButton()
        loadCreateAccountButton()
        
        self.emailField.delegate = self
        self.passwordField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ref = Database.database().reference()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func loadEmailLabel(){
        view.addSubview(emailLabel)
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emailLabel.text = "Email:"
        emailLabel.textColor = .black
        
        let emailLabelFrame = CGRect(x: 0.0, y: 0.0, width: 60, height: 30)
        emailField.frame = emailLabelFrame
        
        setEmailLabelConstraints()
    }
    
    func loadEmailField(){
        view.addSubview(emailField)
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        
        let emailFieldFrame = CGRect(x: 0.0, y: 0.0, width: 332, height: 45)
        emailField.frame = emailFieldFrame
        
        emailField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        emailField.layer.borderWidth = 1
        emailField.layer.cornerRadius = 20
        
        setEmailFieldConstraints()
    }
    
    func loadPasswordLabel(){
        view.addSubview(passwordLabel)
        
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        passwordLabel.text = "Password:"
        passwordLabel.textColor = .black
        
        let passwordLabelFrame = CGRect(x: 0.0, y: 0.0, width: 120, height: 30)
        passwordLabel.frame = passwordLabelFrame
        
        setPasswordLabelConstraints()
    }
    
    func loadPasswordField(){
        view.addSubview(passwordField)
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        let passwordFieldFrame = CGRect(x: 0.0, y: 0.0, width: 332, height: 45)
        passwordField.frame = passwordFieldFrame
        
        passwordField.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        passwordField.layer.borderWidth = 1
        passwordField.layer.cornerRadius = 20
        
        setPasswordFieldConstraints()
    }
    
    func loadSignInButton() {
        signInButton.backgroundColor = .black
        
        view.addSubview(signInButton)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        let signInButtonFrame = CGRect(x: 0.0, y: 0.0, width: (150), height: (38))
        signInButton.frame = signInButtonFrame
        signInButton.layer.cornerRadius = 20
        
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        
        setSignInButtonConstraints()
        
        signInButton.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
    }
    
    
    @objc func signInButtonAction(sender: UIButton!) {
        guard let email = emailField.text else { return}
        guard let password = passwordField.text else { return}

        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {result, error in
            if error == nil{
                print("signed in")
                
                self.dismiss(animated: true)
            }
            else{
                print(error)
            }
        })
    }

    func loadCreateAccountButton() {
        createAccountButton.backgroundColor = .black
        
        view.addSubview(createAccountButton)
        
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        let createAccountButtonFrame = CGRect(x: 0.0, y: 0.0, width: (150), height: (38))
        createAccountButton.frame = createAccountButtonFrame
        createAccountButton.layer.cornerRadius = 20
        
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.setTitleColor(.white, for: .normal)
        
        setCreateAccountButtonConstraints()
        
        createAccountButton.addTarget(self, action: #selector(createAccountButtonAction), for: .touchUpInside)
    }
    
    @objc func createAccountButtonAction(sender: UIButton!){
        guard let email = emailField.text else { return}
        guard let password = passwordField.text else { return}

        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
            if error == nil{
                let createdUser = result?.user
                print("account created")
                //save the users email
                self.ref.child("users").child(createdUser!.uid).child("email").setValue(createdUser?.email)
                //set number of entries to 0
                self.ref.child("users").child(createdUser!.uid).child("numberOfEntries").setValue(0)
                
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss:mm"
                //mark review set as expired
                self.ref.child("users").child(createdUser!.uid)
                    .child("currentReviewSet").child("expiration")
                    .setValue(dateFormatter.string(from: date))
                self.dismiss(animated: true)
            }
            else{
                print(error)
            }
        })
    }
    
    func setEmailLabelConstraints(){
        emailLabel.anchor(top: nil, leading: emailField.leadingAnchor, bottom: emailField.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: (emailLabel.frame.width), height: (emailLabel.frame.height)))

    }
    
    func setEmailFieldConstraints(){
        emailField.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: view.frame.height/3, left: 0, bottom: 0, right: 0), size: .init(width: (emailField.frame.width), height: (emailField.frame.height)))
        NSLayoutConstraint.activate([
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setPasswordLabelConstraints(){
        passwordLabel.anchor(top: nil, leading: passwordField.leadingAnchor, bottom: passwordField.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: (passwordLabel.frame.width), height: (passwordLabel.frame.height)))
    }
    
    func setPasswordFieldConstraints(){
        passwordField.anchor(top: emailField.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 60, left: 0, bottom: 0, right: 0), size: .init(width: (passwordField.frame.width), height: (passwordField.frame.height)))
        NSLayoutConstraint.activate([
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setSignInButtonConstraints(){
        signInButton.anchor(top: passwordField.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 100, left: 0, bottom: 0, right: 0), size: .init(width: (signInButton.frame.width), height: (signInButton.frame.height)))
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setCreateAccountButtonConstraints(){
        createAccountButton.anchor(top: signInButton.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: (createAccountButton.frame.width), height: (createAccountButton.frame.height)))
        NSLayoutConstraint.activate([
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
