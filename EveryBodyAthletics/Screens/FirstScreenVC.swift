//
//  FirstScreenVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/22.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class FirstScreenVC: UIViewController {
    
    var ebaLogo: UIImageView!
    var atHomeButton: EBAButton!
    var inClassButton: EBAButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureLogo()
        configureAtHomeButton()
        configureInClassButton()
    }
    
    func configureLogo () {
        ebaLogo = UIImageView(image: Images.ebaLogo)
        view.addSubview(ebaLogo)
        ebaLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ebaLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            ebaLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ebaLogo.widthAnchor.constraint(equalToConstant: 600),
            ebaLogo.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureAtHomeButton () {
        atHomeButton = EBAButton(backgroundColor: Colors.red, title: "At Home")
        atHomeButton.addTarget(self, action: #selector(goToAtHome), for: .touchUpInside)
        view.addSubview(atHomeButton)
        
        NSLayoutConstraint.activate([
            atHomeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            atHomeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            atHomeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            atHomeButton.heightAnchor.constraint(equalToConstant: 70)
            
        ])
    }
    
    func configureInClassButton () {
        inClassButton = EBAButton(backgroundColor: Colors.red, title: "In Class")
        inClassButton.addTarget(self, action: #selector(goToInClass), for: .touchUpInside)
        view.addSubview(inClassButton)
        
        NSLayoutConstraint.activate([
            inClassButton.bottomAnchor.constraint(equalTo: atHomeButton.topAnchor, constant: -20),
            inClassButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inClassButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inClassButton.heightAnchor.constraint(equalToConstant: 70)
            
        ])
    }
    
    @objc func goToInClass () {
        let adminLoginVC = AdminLoginVC()
        adminLoginVC.modalPresentationStyle = .fullScreen
        self.present(adminLoginVC, animated: true)
        print("in class pressed")
    }
    
    @objc func goToAtHome () {
        print("at home pressed")
    }
}
