//
//  EBAExerciseCell.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/2.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import AVFoundation

class EBAExerciseCell: UITableViewCell {
    
    var exercise: Exercise!
    var doneButton: UIButton!
    var label: EBATitleLabel!
    var done: Bool
    var videoWidth = 214
    static let reuseID = "exerciseCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.done = false
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setExercise (exercise: Exercise) {
        self.exercise = exercise
        configure()
    }
    
    func configure () {
        done = true
        configureButton()
        configureLabel()
    }
    
    @objc func donePressed () {
        done.toggle()
        if done {
            doneButton.setBackgroundImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        } else {
            doneButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    func configureButton () {
        doneButton = UIButton(frame: .zero)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            doneButton.widthAnchor.constraint(equalToConstant: 35),
            doneButton.heightAnchor.constraint(equalToConstant: 35),
            doneButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        if done {
            doneButton.setBackgroundImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        } else {
            doneButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        }
        doneButton.tintColor = Colors.red
        doneButton.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
    }
    
    func configureLabel () {
        label = EBATitleLabel(textAlignment: .left, fontSize: 30)
        label.text = exercise.name
        label.numberOfLines = 0
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: doneButton.leadingAnchor, constant: -20),
        ])
    }
}

