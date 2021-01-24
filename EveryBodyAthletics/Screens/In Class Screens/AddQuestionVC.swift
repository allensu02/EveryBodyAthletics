//
//  AddQuestionVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/11/27.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class AddQuestionVC: UIViewController {
    
    var station: Int!
    var containerView: AddQuestionContainerView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        station = 1
        addGesture()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Add Question"
        configureUI()
    }
    
    func configureUI() {
        containerView = AddQuestionContainerView(station: station)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureAddQuestion() {
        containerView.addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }
    
    @objc func addTapped () {
        
    }
    func addGesture () {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard () {
        view.endEditing(true)
    }
    
}
