//
//  AddQuestionContainerView.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/11/29.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import AnimatedField

class AddQuestionContainerView: UIView {
    
    var format: AnimatedFieldFormat!
    var textFields: [AnimatedField] = []
    var textFieldStackView: UIStackView!
    var station: Int!
    var stationLabel: EBATitleLabel!
    var stationPicker: UIPickerView!
    var stationTextField: EBATextField!
    var stationStackView: UIStackView!
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
        configureTextFields()
        configureStationUI()
        configureAddButton()
    }
    
    func configureTextFields() {
        textFields.append(createTextField(placeholder: "Question Name"))
        for level in Level.allCases {
            textFields.append(createTextField(placeholder: "Level \(level.rawValue) Question"))
        }
        textFieldStackView = UIStackView(arrangedSubviews: textFields)
        textFieldStackView.axis = .vertical
        textFieldStackView.distribution = .fillEqually
        textFieldStackView.spacing = 50
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldStackView)
        
        NSLayoutConstraint.activate([
            textFieldStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            textFieldStackView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            textFieldStackView.widthAnchor.constraint(equalToConstant: 800),
            textFieldStackView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    func createTextField(placeholder: String) -> AnimatedField {
        let textField = AnimatedField()
        textField.format = format
        textField.type = .none
        textField.placeholder = placeholder
        textField.isSecure = false
        textField.showVisibleButton = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
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
            stationStackView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 50),
            stationStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 300),
            stationStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -300),
            stationStackView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    func configureAddButton() {
        addButton = EBAButton(backgroundColor: Colors.red, title: "Add Question")
        addButton.titleLabel?.font = UIFont(name: Fonts.liberator, size: 40)

        self.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: stationStackView.bottomAnchor,constant: 40),
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
