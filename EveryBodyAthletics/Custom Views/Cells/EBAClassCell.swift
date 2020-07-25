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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure () {
        configureTimeLabel()
    }
    
    func configureTimeLabel () {
        timeLabel = EBASecondaryLabel(fontSize: 50)
        timeLabel.text = cellClass.time
        timeLabel.textColor = .black
        addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    
}
