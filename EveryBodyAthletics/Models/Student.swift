//
//  Student.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/24.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

struct Student: Hashable {
    var name: String
    var physLevel: Level
    var socialLevel: Level
    var pfp: String!
    init (name: String, physLevel: Level, socialLevel: Level, pfp: String) {
        self.name = name
        self.physLevel = physLevel
        self.socialLevel = socialLevel
        self.pfp = pfp
    }
    
    static func convertStudentsToArray (students: [Student]) -> Array<[String: Any]> {
        var convertedArray: Array<[String: Any]> = []
        for student in students {
            let convertedStudent = ["name": student.name, "pal": student.physLevel.rawValue, "sal": student.socialLevel.rawValue] as [String : Any]
            convertedArray.append(convertedStudent)
        }
        
        return convertedArray
    }
}
