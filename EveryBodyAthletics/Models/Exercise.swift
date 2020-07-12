//
//  Exercise.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/2.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class Exercise {
    var type: String
    var name: String
    var videoLink: String
    init (name: String, type: String, videoLink: String) {
        self.type = type
        self.name = name
        self.videoLink = videoLink
    }
    
    func setType (type: String) {
        self.type = type
    }
    
    func setName (name: String) {
        self.name = name
    }
    
    func setLink (link: String) {
        self.videoLink = link
    }
    
}

