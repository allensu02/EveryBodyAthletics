//
//  RegisterVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/6/26.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import AnimatedField
import Firebase
import FirebaseFirestore
import FirebaseAuth

class RegisterVC: EBADataLoadingVC {
    var ebaLogo: UIImageView!

    var firstNameTextfield: AnimatedField!
    var lastNameTextfield: AnimatedField!
    var emailTextfield: AnimatedField!
    var passwordTextfield: AnimatedField!
    var registerButton: EBAButton!
    
    var format: AnimatedFieldFormat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = false
        configure()
        // Do any additional setup after loading the view.
    }
    
    func configure () {
        configureFormat()
        configureRegisterButton()
        configurePasswordField()
        configureEmailField()
        configureLastNameField()
        configureFirstNameField()
        configureLogo()
        addGesture()
        configureKeyboard()
        
    }
    
    @objc func signUpClicked () {
        view.endEditing(true)
        if validateFields() {
           
            User.firstName = (firstNameTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
            User.lastName = (lastNameTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
            User.email = (emailTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
            User.password = (passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines))!.lowercased()
            registerUser()
        }
    }
    
    func validateFields () -> Bool {
        if firstNameTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            {
                Alert.showIncompleteFormAlert(on: self)
                return false
        }
        if !Validation.isEmailValid((emailTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines))!) {
            Alert.showInvalidEmailAlert(on: self)
            return false
        }
        if !Validation.isPasswordValid((passwordTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines))) {
            Alert.showInvalidPasswordAlert(on: self)
            return false
        }
        return true
    }
    
    func registerUser () {
        // Create the user
        Auth.auth().createUser(withEmail: User.email, password: User.password) { (result, err) in
            // Check for errors
            if err != nil {
                Alert.showBasicAlert(on: self, with: "Unable To Register User", message: err.debugDescription)
            }
            else {
                self.addUserToDatabase()

                Alert.showUserCreated(on: self)
                self.goToLogin()
            }
        }
        
    }
    
    func addUserToDatabase() {
        let db = Firestore.firestore()
        let newDocument = db.collection("users").document(User.email)
        newDocument.setData(["firstname": User.firstName, "lastname": User.lastName, "email": User.email])
    }
    
    func goToLogin() {
        let loginVC = LoginVC()
        view.window?.rootViewController = loginVC
        view.window?.makeKeyAndVisible()
        
    }
    
    func addGesture () {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard () {
        view.endEditing(true)
    }
    
    func configureKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func configureLogo () {
        ebaLogo = UIImageView(image: Images.ebaLogo)
        view.addSubview(ebaLogo)
        ebaLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ebaLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            ebaLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ebaLogo.widthAnchor.constraint(equalToConstant: 300),
            ebaLogo.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureRegisterButton () {
        registerButton = EBAButton(backgroundColor: Colors.red, title: "Sign Up")
        registerButton.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configurePasswordField () {
        passwordTextfield = AnimatedField()
        passwordTextfield.format = format
        passwordTextfield.type = .password(8, 16)
        passwordTextfield.placeholder = "Password"
        passwordTextfield.isSecure = true
        passwordTextfield.showVisibleButton = true
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextfield)
        NSLayoutConstraint.activate([
            passwordTextfield.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -20),
            passwordTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextfield.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureEmailField () {
        emailTextfield = AnimatedField()
        emailTextfield.format = format
        emailTextfield.type = .email
        emailTextfield.placeholder = "Email"
        emailTextfield.isSecure = false
        emailTextfield.showVisibleButton = false
        emailTextfield.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextfield)
        
        NSLayoutConstraint.activate([
            emailTextfield.bottomAnchor.constraint(equalTo: passwordTextfield.topAnchor, constant: -20),
            emailTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextfield.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureLastNameField() {
        lastNameTextfield = AnimatedField()
        lastNameTextfield.format = format
        lastNameTextfield.type = .none
        lastNameTextfield.placeholder = "Last Name"
        lastNameTextfield.isSecure = false
        lastNameTextfield.showVisibleButton = false
        lastNameTextfield.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lastNameTextfield)
        
        NSLayoutConstraint.activate([
            lastNameTextfield.bottomAnchor.constraint(equalTo: emailTextfield.topAnchor, constant: -20),
            lastNameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lastNameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lastNameTextfield.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureFirstNameField() {
        firstNameTextfield = AnimatedField()
        firstNameTextfield.format = format
        firstNameTextfield.type = .none
        firstNameTextfield.placeholder = "First Name"
        firstNameTextfield.isSecure = false
        firstNameTextfield.showVisibleButton = false
        firstNameTextfield.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstNameTextfield)
        
        NSLayoutConstraint.activate([
            firstNameTextfield.bottomAnchor.constraint(equalTo: lastNameTextfield.topAnchor, constant: -20),
            firstNameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            firstNameTextfield.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureFormat () {
        format = AnimatedFieldFormat()
        format.titleAlwaysVisible = false
        format.titleFont = UIFont(name: Fonts.liberator, size: 20)!
        format.textFont = UIFont(name: Fonts.liberator, size: 25)!
        format.lineColor = Colors.red
        format.titleColor = Colors.red
        format.textColor = Colors.oppositeBackground
        format.visibleOnImage = Icons.eyeOn.withTintColor(.red)
        format.visibleOffImage = Icons.eyeOff.withTintColor(.red)
        format.counterEnabled = false
        /// Highlight color when becomes active
        format.highlightColor = Colors.red
        format.alertEnabled = false
    }
    

}

