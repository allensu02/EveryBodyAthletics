//
//  WorkoutVideoVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/29.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class WorkoutVideoVC: UIViewController {

    var containerView: EBAWorkoutView!
    var exercise: Exercise!
    var student: Student!
    var currentClass: EBAClass!
    var station: Int!
    var videoURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
        title = "Workout"

    }
    
    func configure () {
        configureContainerView()
        containerView.finishButton.addTarget(self, action: #selector(finishPressed), for: .touchUpInside)
    }
    
    func configureContainerView() {
        containerView = EBAWorkoutView(student: student, currentClass: currentClass, station: station)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    @objc func finishPressed () {
        let studentRosterVC = StudentRosterVC()
        studentRosterVC.currentClass = currentClass
        studentRosterVC.station = station
        navigationController?.popToViewController((self.navigationController?.viewControllers[3])!, animated: true)
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.playerLayer?.frame = view.bounds
    }

}
