//
//  EditStudentVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/8/10.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import AnimatedField

class EditStudentVC: UIViewController {
    
    var student: Student!
    var editNameLabel: EBATitleLabel!
    var nameTextfield: AnimatedField!
    var format: AnimatedFieldFormat!
    var palView: EBAAbilityLevelView!
    var selectedPAL: String!
    var selectedSAL: String!
    var salView: EBAAbilityLevelView!
    var alViews: UIStackView!
    var classPicker: UIPickerView!
    var classTextfield: EBATextField!
    var changeImageButton: EBAButton!
    var saveDeleteStackView: UIStackView!
    var deleteButton: EBAButton!
    var saveButton: EBAButton!
    var alertVC: EBAAlertVC!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        title = student.name
        configureAnimatedFieldFormat()
        configureNameTextfield()
        configureALView()
        configureChangeClassPicker()
        configureChangeImageButton()
        configureSaveDeleteStackView()
        configureInitValues()
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        //           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
  
    func configureInitValues () {
        switch student.socialLevel.rawValue {
        case "A":
            salView.setInitButton(button: 0)
        case "B":
            salView.setInitButton(button: 1)
        case "C":
            salView.setInitButton(button: 2)
        default:
            salView.setInitButton(button: 0)
        }
        
        switch student.physLevel.rawValue {
        case "A":
            palView.setInitButton(button: 0)
        case "B":
            palView.setInitButton(button: 1)
        case "C":
            palView.setInitButton(button: 2)
        default:
            palView.setInitButton(button: 0)
        }
    }
    
    func configureNameTextfield () {
        nameTextfield = AnimatedField()
        nameTextfield.format = format
        nameTextfield.type = .none
        nameTextfield.placeholder = "Edit Name"
        nameTextfield.isSecure = false
        nameTextfield.showVisibleButton = false
        nameTextfield.text = student.name
        nameTextfield.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextfield)
        
        NSLayoutConstraint.activate([
            nameTextfield.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            nameTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextfield.heightAnchor.constraint(equalToConstant: 50),
            nameTextfield.widthAnchor.constraint(equalToConstant: 500)
        ])
        
    }
    
    func configureALView () {
        palView = EBAAbilityLevelView(type: "Physical Level")
        salView = EBAAbilityLevelView(type: "Social Level")
        alViews = UIStackView(arrangedSubviews: [palView, salView])
        alViews.axis = .horizontal
        alViews.translatesAutoresizingMaskIntoConstraints = false
        alViews.distribution = .fillEqually
        alViews.spacing = 50
        
        view.addSubview(alViews)
        NSLayoutConstraint.activate([
            alViews.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: 20),
            alViews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            alViews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            alViews.heightAnchor.constraint(equalToConstant: 230)
        ])
    }
    
    func configureChangeClassPicker() {
        classPicker = UIPickerView(frame: .zero)
        classTextfield = EBATextField()
        
        classTextfield.inputView = classPicker
        
        view.addSubview(classTextfield)
        
        NSLayoutConstraint.activate([
            classTextfield.topAnchor.constraint(equalTo: alViews.bottomAnchor, constant: 20),
            classTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            classTextfield.heightAnchor.constraint(equalToConstant: 80),
            classTextfield.widthAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    func configureChangeImageButton () {
        changeImageButton = EBAButton(backgroundColor: Colors.red, title: "Change Image")
        changeImageButton.addTarget(self, action: #selector(ChangeImage), for: .touchUpInside)
        view.addSubview(changeImageButton)
        
        NSLayoutConstraint.activate([
            changeImageButton.topAnchor.constraint(equalTo: classTextfield.bottomAnchor, constant: 20),
            changeImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeImageButton.heightAnchor.constraint(equalToConstant: 80),
            changeImageButton.widthAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    @objc func ChangeImage () {
        print("hi")
    }
    func configureSaveDeleteStackView() {
        saveButton = EBAButton(backgroundColor: Colors.red, title: "Save User")
        saveButton.addTarget(self, action: #selector(saveUser), for: .touchUpInside)
        
        deleteButton = EBAButton(backgroundColor: Colors.red, title: "Delete User")
        deleteButton.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        
        saveDeleteStackView = UIStackView(arrangedSubviews: [deleteButton, saveButton])
        saveDeleteStackView.axis = .horizontal
        saveDeleteStackView.translatesAutoresizingMaskIntoConstraints = false
        saveDeleteStackView.distribution = .fillEqually
        saveDeleteStackView.spacing = 30
        
        view.addSubview(saveDeleteStackView)
        
        NSLayoutConstraint.activate([
            saveDeleteStackView.topAnchor.constraint(equalTo: changeImageButton.bottomAnchor, constant: 20),
            saveDeleteStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveDeleteStackView.heightAnchor.constraint(equalToConstant: 80),
            saveDeleteStackView.widthAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    @objc func saveUser() {
        storeUserInDatabase()
        print("User saved")
        DispatchQueue.main.async {
            self.alertVC = EBAAlertVC(title: "User Saved", message: "User Information Successfully Saved", buttonTitle: "Ok")
            self.alertVC.modalPresentationStyle = .overFullScreen
            self.alertVC.modalTransitionStyle = .crossDissolve
            self.present(self.alertVC,animated: true)
            self.alertVC.actionButton.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)
        }
        
    }
    
    func storeUserInDatabase () {
        print("do firebase shit")
    }
    
    @objc func deletePressed () {
        deleteUserFromDatabase()
    }
    
    func deleteUserFromDatabase () {
        DispatchQueue.main.async {
            self.alertVC = EBAAlertVC(title: "User Deleted", message: "User Information Successfully Deleted", buttonTitle: "Ok")
            self.alertVC.modalPresentationStyle = .overFullScreen
            self.alertVC.modalTransitionStyle = .crossDissolve
            self.present(self.alertVC,animated: true)
            self.alertVC.actionButton.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)
        }
    }
    
    @objc func goBack () {
        alertVC.dismissVC()
        navigationController?.popViewController(animated: true)
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
