//
//  EditStudentVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/8/10.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import AnimatedField
import FirebaseFirestore

class EditStudentVC: UIViewController {
    
    var currentClass: EBAClass!
    var student: Student!
    var alertVC: EBAAlertVC!
    var db = Firestore.firestore()
    var studentView: EBAEditStudentView!
    var classes: [[EBAClass]] = [[]]
    
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
        navigationController?.navigationBar.isHidden = false

        title = student.name
        configureUIView()
        initClasses()
    }
    
    func configureUIView() {
        studentView = EBAEditStudentView(student: student, currentClass: currentClass)
        view.addSubview(studentView)
        studentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            studentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            studentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            studentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            studentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
    }
    
    func initClasses() {
        studentView.classPicker.dataSource = self
        studentView.classPicker.delegate = self
        getClasses { (returnedClasses) in
            self.classes = returnedClasses
            self.studentView.classPicker.reloadAllComponents()
            self.studentView.classPicker.selectRow(self.studentView.getIndexOfClass(), inComponent: 0, animated: true)
        }
        studentView.saveButton.addTarget(self, action: #selector(saveUser), for: .touchUpInside)
        studentView.deleteButton.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        studentView.changeImageButton.addTarget(self, action: #selector(ChangeImage), for: .touchUpInside)
    }

    @objc func ChangeImage () {
        print("hi")
    }
    
    func takeImage () {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
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
        var index = 0
        var thisUser: [String: Any]!
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
                            //finds the student index in the students array
                            for user in users {
                                if (user["name"] as! String != self.student.name) {
                                    index += 1
                                } else {
                                    break
                                }
                            }
                            updatedUsers = users
                        }
                    }
                }
            }
            
            //if user selects new class, student will be removed from the currentClass and will be added to the new class
            if self.studentView.newSelectedClass != nil {
                updatedUsers.remove(at: index)
                let updatedStudent = Student(name: self.studentView.nameTextfield.text!, physLevel: self.studentView.palView.getLevel()!, socialLevel: self.studentView.salView.getLevel()!, pfp: "test")
                self.studentView.newSelectedClass.students.append(updatedStudent)
                self.deleteUserFromDatabase()
                self.db.collection("classes").document(self.studentView.newSelectedClass.docID).setData(self.studentView.newSelectedClass.convertToDict())
                
            } else {
                //student value updated in array and on Firebase
                updatedUsers[index] = ["name": self.studentView.nameTextfield.text, "pal" : self.studentView.palView.getLevel()!.rawValue, "sal": self.studentView.salView.getLevel()!.rawValue]
                self.db.collection("classes").document(self.currentClass.docID).setData(self.currentClass.convertToDict(updatedStudents: updatedUsers))
            }
            
        }
    }
    
    func checkValues() -> Bool {
        if (self.studentView.nameTextfield.text == "") {
            presentEBAAlertOnMainThread(title: "Invalid Name", message: "Please Enter a Valid Student Name", buttonTitle: "Ok")
            return false
        } else if (self.studentView.salView.getLevel() == nil || self.studentView.palView.getLevel() == nil) {
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
}

extension EditStudentVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        for ebaClasses in classes {
            for ebaClass in ebaClasses {
                count += 1
            }
        }
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var count = 0
        for ebaClasses in classes {
            for ebaClass in ebaClasses {
                if (row == count) {
                    return ebaClass.toString()
                }
                count += 1
            }
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        studentView.classTextfield.text = classes[component][row].toString()
        studentView.newSelectedClass = classes[component][row]
    }
    
}

extension EditStudentVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
    }
}
