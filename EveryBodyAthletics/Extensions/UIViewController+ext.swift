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
import FirebaseStorage

extension UIViewController {
    
    
    //pop ups a loading screen
    func showLoadingView() -> UIView {
        
        let containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        activityIndicator.startAnimating()
        return containerView
    }
    
    //dismisses loading screen
    func dismissLoadingView (containerView: UIView) {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
        }
    }
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
        let loadingView = showLoadingView()
        let db = Firestore.firestore()
        
        var students : [Student] = []
        var classes: [[EBAClass]] = [[], []]
        db.collection("classes").getDocuments {[weak self] (snapshot, error) in
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
                            var userPfp: UIImage!
                            
                            let newStudent = Student(name: name, physLevel: Level(rawValue: pal)!, socialLevel: Level(rawValue: sal)!, pfp: "userPfp")
                            students.append(newStudent)
                        }
                    }
                    
                    let dayOfWeek = DayInWeek(rawValue: results["dayOfWeek"] as! String)!
                    
                    let newClass = EBAClass(day: dayOfWeek, startTime: results["startTime"] as! String, endTime: results["endTime"] as! String, students: students, docID: results["docID"] as! String)
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
                self!.dismissLoadingView(containerView: loadingView)
            }
        }
    }
}

