//
//  Constants.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/6/26.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

struct Colors {
    static var red = UIColor(red: 210/255, green: 35/255, blue: 52/255, alpha: 1)
    static var oppositeBackground = UIColor(named: "Opposite")!
}

struct Images {
    static var ebaLogo = UIImage(named: "EBALogo")
}
struct Icons {
    static var eyeOn = UIImage(systemName: "eye.fill")!
    static var eyeOff = UIImage(systemName: "eye.slash.fill")!
}
struct Fonts {
    static var liberator = "Liberator"
}

struct User {
    static var firstName: String = ""
    static var lastName: String = ""
    static var email: String = ""
    static var password: String = ""
}

enum Type {
    case warmUp
    case circuit
    case coolDown
}
