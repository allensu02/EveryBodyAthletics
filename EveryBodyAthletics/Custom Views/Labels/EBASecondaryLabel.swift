//
//  EBASecondaryLabel.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/6/28.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class EBASecondaryLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont(name: Fonts.liberator, size: fontSize)
    }
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.7
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
