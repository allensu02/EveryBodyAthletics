//
//  EBAClassCell.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/24.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class EBAClassCell: UITableViewCell {

    var cellClass: Class!
    var timeLabel: EBASecondaryLabel!
    var containerView: UIView!
    
    static let reuseID = "classCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    func setClass (cellClass: Class) {
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
        configureTimeLabel()
        
    }
    
    func configureTimeLabel () {
        timeLabel = EBASecondaryLabel(fontSize: 50)
        timeLabel.font = .systemFont(ofSize: 35, weight: .black)
        timeLabel.text = "\(cellClass.time)   Students: \(cellClass.students.count)"
        timeLabel.textColor = .black
        containerView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            timeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
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
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
    }
    
}
