//
//  Student.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/24.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class Student {
    var name: String
    var physLevel: Level
    var socialLevel: Level
    var faceImage: UIImage
    init (name: String, physLevel: Level, socialLevel: Level, faceImage: UIImage) {
        self.name = name
        self.physLevel = physLevel
        self.socialLevel = socialLevel
        self.faceImage = faceImage
    }
}
