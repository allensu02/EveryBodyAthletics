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
    var startTime: String
    var endTime: String
    var students: [Student]
    var docID: String
    
    init (day: DayInWeek, startTime: String, endTime: String, students: [Student], docID: String) {
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
        self.students = students
        self.docID = docID
    }
    
    func toString() -> String{
        return day.rawValue + " " + startTime + " to " + endTime
    }
    
    func convertToDict() -> [String: Any] {
        return ["dayOfWeek" : day.rawValue, "docID": docID, "students": Student.convertStudentsToArray(students: students), "startTime" : startTime, "endTime": endTime]
    }
    
    func convertToDict(updatedStudents: Array<[String: Any]>) -> [String: Any] {
        return ["dayOfWeek" : day.rawValue, "docID": docID, "students": updatedStudents, "startTime" : startTime, "endTime": endTime]
    }
    
    func equals(ebaClass: EBAClass) -> Bool{
        return day == ebaClass.day && startTime == ebaClass.startTime && endTime == ebaClass.endTime && docID == ebaClass.docID
    }
}
