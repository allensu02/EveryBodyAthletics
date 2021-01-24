//
//  NewStudentVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/8/10.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import AnimatedField
import FirebaseFirestore

class NewStudentVC: UIViewController {
    
    var currentClass: EBAClass!
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
    var saveButton: EBAButton!
    var alertVC: EBAAlertVC!
    var classes: [[EBAClass]] = [[]]
    var db = Firestore.firestore()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "New Student"
        configureAnimatedFieldFormat()
        configureNameTextfield()
        configureALView()
        configureChangeImageButton()
        configureSaveButton()
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
    
    func configureNameTextfield () {
        nameTextfield = AnimatedField()
        nameTextfield.format = format
        nameTextfield.type = .none
        nameTextfield.placeholder = "Name"
        nameTextfield.isSecure = false
        nameTextfield.showVisibleButton = false
        nameTextfield.text = ""
        nameTextfield.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextfield)
        
        NSLayoutConstraint.activate([
            nameTextfield.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
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
    
    func configureChangeImageButton () {
        changeImageButton = EBAButton(backgroundColor: Colors.red, title: "Change Image")
        changeImageButton.addTarget(self, action: #selector(ChangeImage), for: .touchUpInside)
        view.addSubview(changeImageButton)
        
        NSLayoutConstraint.activate([
            changeImageButton.topAnchor.constraint(equalTo: alViews.bottomAnchor, constant: 20),
            changeImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeImageButton.heightAnchor.constraint(equalToConstant: 80),
            changeImageButton.widthAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    @objc func ChangeImage () {
        print("hi")
    }
    func configureSaveButton() {
        saveButton = EBAButton(backgroundColor: Colors.red, title: "Save User")
        saveButton.addTarget(self, action: #selector(saveUser), for: .touchUpInside)
        
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: changeImageButton.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 80),
            saveButton.widthAnchor.constraint(equalToConstant: 500)
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
        
        var updatedUsers: Array<[String: Any]>!
        guard (checkValues()) else {
            return
        }
        db.collection("classes").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in snapshot!.documents {
                    if (document.documentID == self.currentClass.docID) {
                        let results = document.data()
                        if let users = results["students"] as? Array<[String: Any]> {
                            updatedUsers = users
                        }
                    }
                }
            }
            updatedUsers.append(["name": self.nameTextfield.text!, "pal" : self.palView.getLevel()!.rawValue, "sal": self.salView.getLevel()!.rawValue])
            
            self.db.collection("classes").document(self.currentClass.docID).setData(self.currentClass.convertToDict(updatedStudents: updatedUsers))
        }
    }
    
    func checkValues() -> Bool {
        if (self.nameTextfield.text == "") {
            presentEBAAlertOnMainThread(title: "Invalid Name", message: "Please Enter a Valid Student Name", buttonTitle: "Ok")
            return false
        } else if (self.palView.getLevel() == nil || self.salView.getLevel() == nil) {
            presentEBAAlertOnMainThread(title: "Invalid Info", message: "Please Select a Physical Level and Social Level", buttonTitle: "Ok")
            return false
        }
        return true
    }
    
    @objc func deletePressed () {
        deleteUserFromDatabase()
    }
    
    func deleteUserFromDatabase () {
        var updatedUsers: Array<[String: Any]>!
        db.collection("classes").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in snapshot!.documents {
                    if (document.documentID == self.currentClass.docID) {
                        let results = document.data()
                        //finding inidex of student in student array
                        if let users = results["students"] as? Array<[String: Any]> {
                            var index = 0
                            for user in users {
                                if (user["name"] as! String != self.student.name) {
                                    index += 1
                                } else {
                                    break
                                }
                            }
                            updatedUsers = users
                            updatedUsers.remove(at: index)
                        }
                    }
                }
            }
            
            self.db.collection("classes").document(self.currentClass.docID).setData(self.currentClass.convertToDict(updatedStudents: updatedUsers))
        }
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
        if let vcs = self.navigationController?.viewControllers {
            let previousVC = vcs[vcs.count - 2]
            if previousVC is EditClassVC {
                let prevVC = previousVC as? EditClassVC
                prevVC?.updateClass()
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
    
    func getClassCount() -> Int{
        var count = 0
        for ebaClasses in classes {
            for ebaClass in ebaClasses {
                count += 1
            }
        }
        return count
    }
}

