//
//  EBAProfileImageView.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/26.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit


class EBAProfileImageView: UIImageView {
    
    let placeholderImage = Images.userIcon
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
}
