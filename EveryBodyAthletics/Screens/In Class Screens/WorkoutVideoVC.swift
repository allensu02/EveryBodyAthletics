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
    var currentClass: EBAClass!
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
        configureFinishButton()
        configureAVPlayer()

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
            finishButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
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
        videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
        var videoPlayer = UIView(frame: .zero)
        
        view.addSubview(videoPlayer)
        videoPlayer.translatesAutoresizingMaskIntoConstraints = false
        videoPlayer.backgroundColor = .white
        let backgroundImage = UIImageView(frame: videoPlayer.bounds)
        backgroundImage.contentMode =  .scaleAspectFit
        videoPlayer.insertSubview(backgroundImage, at: 0)
        NSLayoutConstraint.activate([
            videoPlayer.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            videoPlayer.bottomAnchor.constraint(equalTo: finishButton.topAnchor, constant: -30),
            videoPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200),
            videoPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -200)
        ])
        
        var playerView =  EBAPlayerView()
        videoPlayer.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.leadingAnchor.constraint(equalTo: videoPlayer.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: videoPlayer.trailingAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: videoPlayer.widthAnchor, multiplier: 16/9).isActive = true
        playerView.centerYAnchor.constraint(equalTo: videoPlayer.centerYAnchor).isActive = true

        playerView.play(with: videoURL)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        playerLayer?.frame = view.bounds
    }

}
