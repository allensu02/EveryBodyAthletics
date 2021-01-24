//
//  EBAEditStudentView.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/11/28.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import AnimatedField
import FirebaseFirestore

class EBAEditStudentView: UIView {

    var currentClass: EBAClass!
    var student: Student!
    var editNameLabel: EBATitleLabel!
    var nameTextfield: AnimatedField!
    var format: AnimatedFieldFormat!
    var palView: EBAAbilityLevelView!
    var salView: EBAAbilityLevelView!
    var alViews: UIStackView!
    var classPicker: UIPickerView!
    var classTextfield: EBATextField!
    var changeImageButton: EBAButton!
    var saveDeleteStackView: UIStackView!
    var deleteButton: EBAButton!
    var saveButton: EBAButton!
    var classes: [[EBAClass]] = [[]]
    var newSelectedClass: EBAClass!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(student: Student, currentClass: EBAClass) {
        super.init(frame: .zero)
        self.student = student
        self.currentClass = currentClass
        configureUI()
    }
    
    func configureUI() {
        addGesture()
        configureAnimatedFieldFormat()
        configureNameTextfield()
        configureALView()
        configureInitValues()
        configureChangeClassPicker()
        configureChangeImageButton()
        configureSaveDeleteStackView()
    }

    func addGesture () {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = true
        self.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard () {
        self.endEditing(true)
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
        self.addSubview(nameTextfield)

        NSLayoutConstraint.activate([
            nameTextfield.topAnchor.constraint(equalTo: self.topAnchor),
            nameTextfield.centerXAnchor.constraint(equalTo: self.centerXAnchor),
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

        self.addSubview(alViews)
        NSLayoutConstraint.activate([
            alViews.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: 20),
            alViews.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            alViews.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            alViews.heightAnchor.constraint(equalToConstant: 230)
        ])
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
    
    func configureChangeClassPicker() {
        classPicker = UIPickerView(frame: .zero)
        classTextfield = EBATextField()

        classTextfield.inputView = classPicker
        classTextfield.setSize(size: 30)
        classTextfield.text = currentClass.toString()
        self.addSubview(classTextfield)

        NSLayoutConstraint.activate([
            classTextfield.topAnchor.constraint(equalTo: alViews.bottomAnchor, constant: 20),
            classTextfield.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            classTextfield.heightAnchor.constraint(equalToConstant: 80),
            classTextfield.widthAnchor.constraint(equalToConstant: 500)
        ])
    }

    func getIndexOfClass () -> Int{
        var count = 0
        for classesPerDay in classes {
            for ebaClass in classesPerDay {
                if currentClass.equals(ebaClass: ebaClass) {
                    return count
                } else {
                    count += 1
                }
            }
        }
        return count
    }

    func configureChangeImageButton () {
        changeImageButton = EBAButton(backgroundColor: Colors.red, title: "Change Image")
        self.addSubview(changeImageButton)

        NSLayoutConstraint.activate([
            changeImageButton.topAnchor.constraint(equalTo: classTextfield.bottomAnchor, constant: 20),
            changeImageButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            changeImageButton.heightAnchor.constraint(equalToConstant: 80),
            changeImageButton.widthAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    func configureSaveDeleteStackView() {
        saveButton = EBAButton(backgroundColor: Colors.red, title: "Save User")
        
        deleteButton = EBAButton(backgroundColor: Colors.red, title: "Delete User")
        
        saveDeleteStackView = UIStackView(arrangedSubviews: [deleteButton, saveButton])
        saveDeleteStackView.axis = .horizontal
        saveDeleteStackView.translatesAutoresizingMaskIntoConstraints = false
        saveDeleteStackView.distribution = .fillEqually
        saveDeleteStackView.spacing = 30
        
        self.addSubview(saveDeleteStackView)
        
        NSLayoutConstraint.activate([
            saveDeleteStackView.topAnchor.constraint(equalTo: changeImageButton.bottomAnchor, constant: 20),
            saveDeleteStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            saveDeleteStackView.heightAnchor.constraint(equalToConstant: 80),
            saveDeleteStackView.widthAnchor.constraint(equalToConstant: 500)
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
        format.highlightColor = Colors.red
        format.alertEnabled = false
    }
}
