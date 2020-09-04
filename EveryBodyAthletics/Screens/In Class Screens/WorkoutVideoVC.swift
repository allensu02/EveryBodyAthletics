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

    var headerLabel: EBATitleLabel!
    var exercise: Exercise!
    var student: Student!
    var finishButton: EBAButton!
    var currentClass: Class!
    var station: Int!
    var player: AVPlayer!
    var videoURL: URL!
    var playerLayer: AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
        title = "Workout"

    }
    
    func configure () {
        configureHeaderLabel()
        configureAVPlayer()
        configureFinishButton()
    }
    
    func configureHeaderLabel () {
        headerLabel = EBATitleLabel(textAlignment: .center, fontSize: 50)
        headerLabel.numberOfLines = 0
        headerLabel.text = "Workout of the Day for \(student.name)"
        view.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            headerLabel.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func configureFinishButton () {
        finishButton = EBAButton(backgroundColor: Colors.red, title: "Finish Workout")
        finishButton.titleLabel?.font = UIFont(name: Fonts.liberator, size: 40)
        view.addSubview(finishButton)
        
        NSLayoutConstraint.activate([
            finishButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            finishButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200),
            finishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -200),
            finishButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        finishButton.addTarget(self, action: #selector(finishPressed), for: .touchUpInside)
    }
    
    @objc func finishPressed () {
        let studentRosterVC = StudentRosterVC()
        studentRosterVC.currentClass = currentClass
        studentRosterVC.station = station
        navigationController?.popToViewController((self.navigationController?.viewControllers[3])!, animated: true)
    }

    func configureAVPlayer() {
        videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        player = AVPlayer(url: videoURL!)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(origin: self.view.bounds.origin, size: CGSize(width: view.bounds.size.width/2, height: view.bounds.size.height/2))
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }

}
