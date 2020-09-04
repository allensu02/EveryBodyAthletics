//
//  EBAAbilityLevelView.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/8/11.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class EBAAbilityLevelView: UIView {

    var type: String!
    var levelLabel: EBATitleLabel!
    var buttons: [EBAButton] = []
    var buttonStackView: UIStackView!
    var buttonPressed: Int!
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    init (type: String) {
        self.type = type
        super.init(frame: .zero)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure () {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        configureLevelLabel()
        configureStackView()
    }
    
    func configureLevelLabel () {
        levelLabel = EBATitleLabel(textAlignment: .center, fontSize: 50)
        if type != nil {
            levelLabel.text = type
        }
        addSubview(levelLabel)
        
        NSLayoutConstraint.activate([
            levelLabel.topAnchor.constraint(equalTo: topAnchor),
            levelLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            levelLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            levelLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configureStackView () {
        let buttonA = EBAButton(backgroundColor: Colors.red, title: "A")
        let buttonB = EBAButton(backgroundColor: Colors.red, title: "B")
        let buttonC = EBAButton(backgroundColor: Colors.red, title: "C")
        buttons = [buttonA, buttonB, buttonC]
        var i = 0
        for button in buttons {
            
            button.frame.size.width = 80
            button.frame.size.height = 80
            button.tag = i
            button.titleLabel?.font = .systemFont(ofSize: 80, weight: .black)
            button.addTarget(self, action: #selector(levelButtonPressed), for: .touchUpInside)
            i+=1
        }
        buttonStackView = UIStackView(arrangedSubviews: buttons)
        buttonStackView.axis = .horizontal
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 20
        
        addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 10),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    @objc func levelButtonPressed (button: EBAButton) {
        if buttonPressed != nil {
            buttons[buttonPressed].setTitleColor(.white, for: .normal)
            buttons[buttonPressed].backgroundColor = Colors.red
        }
        buttonPressed = button.tag
        button.backgroundColor = .black
        button.setTitleColor(Colors.red, for: .normal)
    }
    
    func setInitButton (button: Int) {
        levelButtonPressed(button: buttons[button])
    }
    
}
