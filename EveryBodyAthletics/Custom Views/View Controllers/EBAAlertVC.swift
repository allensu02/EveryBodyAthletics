//
//  CATAlertVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/6/28.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class EBAAlertVC: UIViewController {
    let titleLabel = EBATitleLabel(textAlignment: .center, fontSize: 50)
    let messageLabel = EBABodyLabel(textAlignment: .center)
    let actionButton = EBAButton(backgroundColor: .systemPink, title: "Ok")
    let containerView = EBAAlertContainerView()
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubview(containerView)
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(actionButton)

        configureContainerView()
        configureTitleLabel()
        configureButton()
        configureMessageLabel()
    }
    
    func configureContainerView () {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 560),
            containerView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    func configureTitleLabel () {
        titleLabel.text = alertTitle ?? "Something went wrong"
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo:  containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 56)
        ])
        
    }
    
    func configureMessageLabel () {
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.font = UIFont(name: Fonts.liberator, size: 30)
        messageLabel.numberOfLines = 4
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
            
            
        ])
    }
    
    func configureButton () {
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.titleLabel?.font = UIFont(name: Fonts.liberator, size: 30)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo:  containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func dismissVC () {
        dismiss(animated: true)
    }
}

