//
//  EBAClassCell.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/24.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class EBAClassCell: UITableViewCell {

    var cellClass: EBAClass!
    var startLabel: EBASecondaryLabel!
    var endLabel: EBASecondaryLabel!
    var studentsLabel: EBASecondaryLabel!

    var containerView: UIView!
    
    static let reuseID = "classCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    func setClass (cellClass: EBAClass) {
        self.cellClass = cellClass
        configure()
        
    }
    
    func clear () {
        if containerView != nil {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure () {
        configureContainerView()
        configureStartLabel()
        configureEndLabel()
        configureStudentsLabel()
        
    }
    
    func configureStartLabel () {
        startLabel = EBASecondaryLabel(fontSize: 50)
        startLabel.font = .systemFont(ofSize: 35, weight: .black)
        startLabel.text = "\(cellClass.startTime)"
        startLabel.textColor = .black
        containerView.addSubview(startLabel)
        NSLayoutConstraint.activate([
            startLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            startLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            startLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            startLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func configureEndLabel () {
        endLabel = EBASecondaryLabel(fontSize: 50)
        endLabel.font = .systemFont(ofSize: 35, weight: .black)
        endLabel.text = "\(cellClass.endTime)"
        endLabel.textColor = .black
        containerView.addSubview(endLabel)
        NSLayoutConstraint.activate([
            endLabel.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 5),
            endLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            endLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            endLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func configureStudentsLabel () {
        studentsLabel = EBASecondaryLabel(fontSize: 50)
        studentsLabel.font = .systemFont(ofSize: 35, weight: .black)
        studentsLabel.text = "\(cellClass.students.count) Athletes"
        studentsLabel.textColor = .black
        containerView.addSubview(studentsLabel)
        NSLayoutConstraint.activate([
            studentsLabel.topAnchor.constraint(equalTo: endLabel.bottomAnchor, constant: 5),
            studentsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            studentsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            studentsLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configureContainerView () {
        containerView = UIView()
        containerView.backgroundColor = Colors.red.withAlphaComponent(0.5)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 15
        containerView.layer.masksToBounds = true
        
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
    }
    
}
