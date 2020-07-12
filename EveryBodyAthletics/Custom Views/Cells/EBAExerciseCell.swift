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
    var exerciseImage: UIImageView!
    var label: EBATitleLabel!
    
    var videoWidth = 214
    static let reuseID = "exerciseCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
        configureLabel()
    }
    
    func configureLabel () {
        label = EBATitleLabel(textAlignment: .left, fontSize: 25)
        label.text = exercise.name
        label.numberOfLines = 0
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    

}
