//
//  Class.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/24.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import Foundation


class Class {
    var day: DayInWeek
    var time: String
    var students: [Student]
    
    init (day: DayInWeek, time: String, students: [Student]) {
        self.day = day
        self.time = time
        self.students = students
    }
}
