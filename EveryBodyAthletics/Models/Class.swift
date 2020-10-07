//
//  Class.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/24.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import Foundation


class EBAClass {
    var day: DayInWeek
    var time: String
    var students: [Student]
    var docID: String
    
    init (day: DayInWeek, time: String, students: [Student], docID: String) {
        self.day = day
        self.time = time
        self.students = students
        self.docID = docID
    }
}
