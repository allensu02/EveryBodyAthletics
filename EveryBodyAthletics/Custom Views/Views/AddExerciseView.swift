//
//  AddExerciseView.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/11/29.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import AnimatedField

class AddExerciseView: UIView {

    var type: String!
    var button: EBAButton!
    var textField: AnimatedField!
    var format: AnimatedFieldFormat!
    var image: UIImage!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(format: AnimatedFieldFormat, level: Level) {
        super.init(frame: .zero)
        self.format = format
        self.type = level.rawValue
        configureUI()
    }
    
    func configureUI() {
        configureTextField()
        configureButton()
    }
    
    func configureTextField() {
        textField = AnimatedField()
        textField.format = format
        textField.type = .none
        textField.placeholder = "Name"
        textField.isSecure = false
        textField.showVisibleButton = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
    
    func configureButton() {
        button = EBAButton(backgroundColor: Colors.red, title: type!)
        button.titleLabel?.font = UIFont(name: Fonts.liberator, size: 40)

        self.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            button.heightAnchor.constraint(equalToConstant: 80),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func configureImage() {
        image = UIImage(systemName: "checkmark.circle")
    }

}
