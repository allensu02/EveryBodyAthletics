//
//  AddWorkoutContainerView.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/11/28.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import AnimatedField

class AddWorkoutContainerView: UIView {
    
    var format: AnimatedFieldFormat!
    var nameTextField: AnimatedField!
    var exerciseCells: [AddExerciseView] = []
    var exerciseStackView: UIStackView!
    var stationStackView: UIStackView!
    var station: Int!
    var stationLabel: EBATitleLabel!
    var stationPicker: UIPickerView!
    var stationTextField: EBATextField!
    var addButton: EBAButton!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(station: Int) {
        super.init(frame: .zero)
        self.station = station
        configureUI()
    }
    
    func configureUI() {
        addGesture()
        configureAnimatedFieldFormat()
        configureNameTextField()
        configureExerciseStackView()
        configureStationUI()
        configureAddButton()
    }
    
    func configureNameTextField() {
        nameTextField = AnimatedField()
        nameTextField.format = format
        nameTextField.type = .none
        nameTextField.placeholder = "Exercise Name"
        nameTextField.isSecure = false
        nameTextField.showVisibleButton = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            nameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.widthAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    func configureExerciseStackView() {
        Level.allCases.forEach {
            let addView = AddExerciseView(format: format, level: $0)
            exerciseCells.append(addView)
        }
        exerciseStackView = UIStackView(arrangedSubviews: exerciseCells)
        exerciseStackView.translatesAutoresizingMaskIntoConstraints = false
        exerciseStackView.axis = .horizontal
        exerciseStackView.distribution = .fillEqually
        exerciseStackView.spacing = 30
        self.addSubview(exerciseStackView)
        
        NSLayoutConstraint.activate([
            exerciseStackView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 50),
            exerciseStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
            exerciseStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
            exerciseStackView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
    }
    
    func configureStationUI () {
        stationLabel = EBATitleLabel(textAlignment: .center, fontSize: 30)
        stationLabel.text = "Station"
        
        stationPicker = UIPickerView(frame: .zero)
        stationTextField = EBATextField()
        
        stationTextField.inputView = stationPicker
        stationTextField.setSize(size: 30)
        stationTextField.text = "Station \(station!)"
        
        stationStackView = UIStackView(arrangedSubviews: [stationLabel, stationTextField])
        stationStackView.translatesAutoresizingMaskIntoConstraints = false
        stationStackView.axis = .horizontal
        stationStackView.distribution = .fillProportionally
        stationStackView.spacing = 20
        
        self.addSubview(stationStackView)
        
        NSLayoutConstraint.activate([
            stationStackView.topAnchor.constraint(equalTo: exerciseStackView.bottomAnchor, constant: 50),
            stationStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 300),
            stationStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -300),
            stationStackView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func configureAddButton() {
        addButton = EBAButton(backgroundColor: Colors.red, title: "Add Exercise")
        addButton.titleLabel?.font = UIFont(name: Fonts.liberator, size: 40)

        self.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: stationStackView.bottomAnchor,constant: 30),
            addButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 400),
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -400),
            addButton.heightAnchor.constraint(equalToConstant: 80)
            
        ])
    }
    
    func configureAnimatedFieldFormat () {
        format = AnimatedFieldFormat()
        format.titleAlwaysVisible = false
        format.titleFont = UIFont(name: Fonts.liberator, size: 20)!
        format.textFont = UIFont(name: Fonts.liberator, size: 30)!
        format.lineColor = Colors.red
        format.titleColor = Colors.red
        format.textColor = Colors.oppositeBackground
        format.visibleOnImage = Icons.eyeOn.withTintColor(.red)
        format.visibleOffImage = Icons.eyeOff.withTintColor(.red)
        format.counterEnabled = false
        format.highlightColor = Colors.red
        format.alertEnabled = false
    }
    
    func addGesture () {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = true
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard () {
        self.endEditing(true)
    }
}
