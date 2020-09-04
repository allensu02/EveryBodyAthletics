//
//  AdminLoginVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/23.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import AnimatedField

class AdminLoginVC: UIViewController {
    
    var ebaLogo: UIImageView!
    var stationLabel: EBATitleLabel!
    
    var buttonStackView: UIStackView!
    var stationButtons: [EBAButton] = []
    
    var adminTextfield: AnimatedField!
    var format: AnimatedFieldFormat!

    var goButton: EBAButton!
    var buttonPressed: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogo()
        configureStationLabel()
        configureButtons()
        configureAnimatedFieldFormat()
        configureAdminTextfield()
        configureGoButton()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        navigationController?.navigationBar.isHidden = false
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
    
    func configureLogo () {
        ebaLogo = UIImageView(image: Images.ebaLogo)
        view.addSubview(ebaLogo)
        ebaLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ebaLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            ebaLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ebaLogo.widthAnchor.constraint(equalToConstant: 600),
            ebaLogo.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureStationLabel () {
        stationLabel = EBATitleLabel(textAlignment: .center, fontSize: 80)
        view.addSubview(stationLabel)
        NSLayoutConstraint.activate([
            
            stationLabel.topAnchor.constraint(equalTo: ebaLogo.bottomAnchor, constant: 25),
            stationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stationLabel.heightAnchor.constraint(equalToConstant: 100),
            stationLabel.widthAnchor.constraint(equalToConstant: 500)
        ])
        
        stationLabel.text = "Station"
    }
    
    func configureButtons() {
        for i in 1...7 {
            let button = EBAButton(backgroundColor: Colors.red, title: String(i))
            button.frame.size.width = 100
            button.frame.size.height = 100
            button.tag = i
            
            button.addTarget(self, action: #selector(stationButtonPressed), for: .touchUpInside)
            roundButton(button: button)
            stationButtons.append(button)
        }
        buttonStackView = UIStackView(arrangedSubviews: stationButtons)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 20
        view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: stationLabel.bottomAnchor, constant: 15),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            buttonStackView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
    }
    
    @objc func stationButtonPressed (button: EBAButton) {
        if buttonPressed != nil {
            stationButtons[buttonPressed - 1].setTitleColor(.white, for: .normal)
            stationButtons[buttonPressed - 1].backgroundColor = Colors.red
        }
        buttonPressed = button.tag
        button.backgroundColor = .black
        button.setTitleColor(Colors.red, for: .normal)
    }
    func roundButton (button: EBAButton) {
        button.titleLabel?.font = .systemFont(ofSize: 80, weight: .black)
        button.layer.cornerRadius = 50
        button.layer.masksToBounds = true
        button.clipsToBounds = true
    }
    
    func configureAdminTextfield () {
        adminTextfield = AnimatedField()
        adminTextfield.format = format
        adminTextfield.type = .password(8, 16)
        adminTextfield.placeholder = "Password"
        adminTextfield.isSecure = true
        adminTextfield.showVisibleButton = true
        adminTextfield.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(adminTextfield)
        NSLayoutConstraint.activate([
            adminTextfield.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 35),
            adminTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            adminTextfield.widthAnchor.constraint(equalToConstant: 350),
            adminTextfield.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configureGoButton () {
        goButton = EBAButton(backgroundColor: Colors.red, title: "Go")
        view.addSubview(goButton)
        goButton.titleLabel?.font = UIFont(name: Fonts.liberator, size: 40)
        goButton.addTarget(self, action: #selector(goButtonPressed), for: .touchUpInside)
        NSLayoutConstraint.activate([
            goButton.topAnchor.constraint(equalTo: adminTextfield.bottomAnchor, constant: 30),
            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goButton.widthAnchor.constraint(equalToConstant: 350),
            goButton.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    @objc func goButtonPressed () {
        let classesVC = ClassesVC()
        
        if buttonPressed == nil {
            presentEBAAlertOnMainThread(title: "Select Station", message: "Please select a station for the workout", buttonTitle: "Ok")
        } else {
            classesVC.station = buttonPressed
            
            navigationController?.pushViewController(classesVC, animated: true)
            for button in stationButtons {
                if button.backgroundColor == .black{
                    button.backgroundColor = Colors.red
                    button.titleLabel?.textColor = .white
                }
            }
        }
        
        
        
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
