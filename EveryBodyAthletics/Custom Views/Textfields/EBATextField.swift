//
//  EBATextfield.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/8/14.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class EBATextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont(name: Fonts.liberator, size: 25)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = Colors.red.withAlphaComponent(0.3)
        autocorrectionType = .no
        clearButtonMode = .whileEditing
        placeholder = "Change Class"
        returnKeyType = .go
    }

}

