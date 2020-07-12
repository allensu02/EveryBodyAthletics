//
//  ViewController.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/6/26.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import AnimatedField
import Firebase
import FirebaseAuth
import FirebaseFirestore

class LoginVC: EBADataLoadingVC {
    var backgroundView: UIView!
    var ebaLogo: UIImageView!
    var emailTextfield: AnimatedField!
    var passwordTextfield: AnimatedField!
    var format: AnimatedFieldFormat!
    
    var loginButton: EBAButton!
    
    var registerView: UIView!
    var registerLabel: EBASecondaryLabel!
    var registerButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        emailTextfield.restart()
        passwordTextfield.restart()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        configureAnimatedFieldFormat()
        configureLogo()
        configureRegisterView()
        configureLoginButton()
        configurePasswordField()
        configureEmailField()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        addGesture()
    }
    
    func addGesture () {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard () {
        view.endEditing(true)
    }
    
    @objc func goToLogin () {
        view.endEditing(true)
        if validateFields() {
            showLoadingView()
            Auth.auth().signIn(withEmail: (emailTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, password: (passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines))!.lowercased()) { (result, error) in
                self.dismissLoadingView()
                if let err = error {
                    Alert.showIncorrectAuth(on: self)
                    print(err.localizedDescription)
                } else {
                    self.transitionToMenu()
                }
            }
        }
        
    }
    
    func validateFields() -> Bool{
        if emailTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            Alert.showIncompleteFormAlert(on: self)
            return false
        }
        return true
    }
    
    func transitionToMenu() {
        let tabBarController = EBATabBarController()
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
    }
    
    @objc func goToRegister() {
        let registerController = RegisterVC()
        navigationController?.pushViewController(registerController, animated: true)
    }
    
    func configureLogo () {
        ebaLogo = UIImageView(image: Images.ebaLogo)
        view.addSubview(ebaLogo)
        ebaLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ebaLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            ebaLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ebaLogo.widthAnchor.constraint(equalToConstant: 300),
            ebaLogo.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureRegisterView () {
        registerView = UIView()
        registerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerView)
        
        registerLabel = EBASecondaryLabel(fontSize: 16)
        registerLabel.text = "Don't have an account?"
        registerView.addSubview(registerLabel)
        
        registerButton = UIButton()
        registerButton.titleLabel?.font = UIFont(name: Fonts.liberator, size: 16)
        registerButton.setTitle("Sign Up Here", for: .normal)
        registerButton.setTitleColor(Colors.red, for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
        registerView.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
        
            registerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            registerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerView.widthAnchor.constraint(equalToConstant: 300),
            registerView.heightAnchor.constraint(equalToConstant: 30),
            
            registerLabel.topAnchor.constraint(equalTo: registerView.topAnchor),
            registerLabel.leadingAnchor.constraint(equalTo: registerView.leadingAnchor),
            registerLabel.widthAnchor.constraint(equalToConstant: 190),
            registerLabel.bottomAnchor.constraint(equalTo: registerView.bottomAnchor),
            
            registerButton.topAnchor.constraint(equalTo: registerView.topAnchor),
            registerButton.leadingAnchor.constraint(equalTo: registerLabel.trailingAnchor),
            registerButton.bottomAnchor.constraint(equalTo: registerView.bottomAnchor),
            registerButton.trailingAnchor.constraint(equalTo: registerView.trailingAnchor)
        ])
        
    }
    
    func configureLoginButton () {
        loginButton = EBAButton(backgroundColor: Colors.red, title: "Log In")
        loginButton.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: registerView.topAnchor, constant: -20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
            
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
            passwordTextfield.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20),
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
    
    func configureAnimatedFieldFormat () {
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
    
}


