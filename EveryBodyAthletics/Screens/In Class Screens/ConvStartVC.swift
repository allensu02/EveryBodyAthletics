//
//  ConvStartVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/29.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class ConvStartVC: UIViewController {

    var student: Student!
    var headerLabel: EBATitleLabel!
    var questionLabel: EBATitleLabel!
    var answerButton: EBAButton!
    var currentClass: Class!
    var station: Int!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configure()
        title = "Conversation Starter"
        navigationItem.largeTitleDisplayMode = .never
        
    }

    func configure() {
        configureHeaderLabel()
        configureAnswerButton()
        configureQuestionLabel()
    }
    
    func configureHeaderLabel () {
        headerLabel = EBATitleLabel(textAlignment: .center, fontSize: 50)
        headerLabel.numberOfLines = 0
        headerLabel.text = "Question of the Day for \(student.name)"
        view.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            headerLabel.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func configureAnswerButton () {
        answerButton = EBAButton(backgroundColor: Colors.red, title: "Answered")
        answerButton.titleLabel?.font = UIFont(name: Fonts.liberator, size: 40)
        view.addSubview(answerButton)
        
        NSLayoutConstraint.activate([
            answerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            answerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200),
            answerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -200),
            answerButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        answerButton.addTarget(self, action: #selector(answerPressed), for: .touchUpInside)
    }
    
    @objc func answerPressed () {
        let workoutVC = WorkoutVideoVC()
        workoutVC.student = student
        workoutVC.currentClass = currentClass
        workoutVC.station = station
        navigationController?.pushViewController(workoutVC, animated: true)
    }
    
    func configureQuestionLabel () {
        questionLabel = EBATitleLabel(textAlignment: .center, fontSize: 70)
        questionLabel.numberOfLines = 0
        questionLabel.text = "If you could vacation anywhere in the world, where would you go? Why?"
        view.addSubview(questionLabel)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 50),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            questionLabel.bottomAnchor.constraint(equalTo: answerButton.topAnchor, constant: -100)
        ])
    }
}
