//
//  AddWorkoutVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/11/27.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class AddWorkoutVC: UIViewController {
    
    var containerView: AddWorkoutContainerView!
    var station: Int!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Add Workout"
        configureUI()
    }
    
    func configureUI () {
        containerView = AddWorkoutContainerView(station: station)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureExerciseButtons() {
        for cell in containerView.exerciseCells {
            cell.button.addTarget(self, action: #selector(addVideo), for: .touchUpInside)
        }
    }
    
    @objc func addVideo(sender: UIButton!) {
        
    }
    
    func configureStationPicker() {
        containerView.stationPicker.delegate = self
        containerView.stationPicker.dataSource = self
    }
    
    func configureAddButton() {
        containerView.addButton.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
    }
    
    @objc func addPressed() {
        print("implement add pressed on addworkoutvc")
    }
    
}

extension AddWorkoutVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    
}
