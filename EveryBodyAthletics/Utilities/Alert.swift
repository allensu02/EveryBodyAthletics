//
//  Alert.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/6/28.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

struct Alert {
    static func showBasicAlert (on vc: UIViewController, with title: String, message: String) {
        let alert = EBAAlertVC(title: title, message: message, buttonTitle: "Ok")
        DispatchQueue.main.async {
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            vc.present(alert,animated: true)
        }
    }
    
    static func showIncompleteFormAlert (on vc: UIViewController) {
        Alert.showBasicAlert(on: vc, with: "Incomplete Form", message: "Please fill in all fields")
    }
    
    static func showInvalidEmailAlert (on vc: UIViewController) {
        Alert.showBasicAlert(on: vc, with: "Invalid Email Address", message:"Please enter a valid email address")
    }
    
    static func showInvalidPasswordAlert (on vc: UIViewController) {
        Alert.showBasicAlert(on: vc, with: "Invalid Password", message: "Password must contain at least 8 characters, a special character and number.")
    }
    
    static func showIncorrectAuth (on vc: UIViewController) {
        Alert.showBasicAlert(on: vc, with: "Login failed", message: "Wrong username or password, try again")
    }
    
    static func showUserCreated(on vc: UIViewController) {
        Alert.showBasicAlert(on: vc, with: "User Created", message: "Go Back to Login")
        
    }
}
