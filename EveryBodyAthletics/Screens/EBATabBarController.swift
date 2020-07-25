//
//  EBATabBarController.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/6/26.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class EBATabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isHidden = false
        self.viewControllers = [configureExercisesNC(), configureProfileNC()]
        
    }
    
    func configureExercisesNC () -> UINavigationController {
        let exercisesVC = ExercisesVC()
        let boldConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
        exercisesVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "list.bullet.below.rectangle", withConfiguration: boldConfiguration)?.withTintColor(Colors.red), tag: 0)
        let exercisesNC = UINavigationController(rootViewController: exercisesVC)

        return exercisesNC
    }
    
    func configureProfileNC () -> UINavigationController {
        let profileVC = ProfileVC()
        let boldConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
        let tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person", withConfiguration: boldConfiguration)?.withTintColor(Colors.red), tag: 1)
        profileVC.tabBarItem = tabBarItem
        let profileNC = UINavigationController(rootViewController: profileVC)
        return profileNC
    }
    
}
