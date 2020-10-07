//
//  UIViewController+ext.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/6/28.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import SafariServices
import FirebaseFirestore

extension UIViewController {
    
    //presents an alert
    func presentEBAAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = EBAAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC,animated: true)
        }
    }
    
    func presentSafariVC (url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    func getClasses (onCompletion: @escaping ([[EBAClass]]) -> Void) {
        let db = Firestore.firestore()
        var students : [Student] = []
        var classes: [[EBAClass]] = [[]]
        db.collection("classes").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in snapshot!.documents {
                    let results = document.data()
                    if let users = results["students"] as? Array<[String: Any]> {
                        for user in users {
                            let name = user["name"] as? String ?? "??"
                            let pal = user["pal"] as? String ?? "??"
                            let sal = user["sal"] as? String ?? "??"
                            let newStudent = Student(name: name, physLevel: Level(rawValue: pal)!, socialLevel: Level(rawValue: sal)!, faceImage: Images.userIcon)
                            students.append(newStudent)
                        }
                    }
                    
                    let dayOfWeek = DayInWeek(rawValue: results["dayOfWeek"] as! String)!
                    
                    let newClass = EBAClass(day: dayOfWeek, time: results["time"] as! String, students: students, docID: results["docID"] as! String)
                    
                    switch dayOfWeek {
                    case .monday: classes[0].append(newClass)
                    case .tuesday: classes[1].append(newClass)
                    case .wednesday: classes[2].append(newClass)
                    case .thursday: classes[3].append(newClass)
                    case .friday: classes[4].append(newClass)
                    case .saturday: classes[5].append(newClass)
                    case .sunday: classes[6].append(newClass)
                    }
                    students = []
                }
                onCompletion(classes)
            }
        }
    }
}

