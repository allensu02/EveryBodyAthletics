//
//  EBAWorkoutView.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/11/28.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import FirebaseStorage

class EBAWorkoutView: UIView {

    var headerLabel: EBATitleLabel!
    var nameLabel: EBATitleLabel!
    var exercise: Exercise!
    var student: Student!
    var finishButton: EBAButton!
    var currentClass: EBAClass!
    var station: Int!
    var player: AVPlayer!
    var videoURL: URL!
    var playerLayer: AVPlayerLayer!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(student: Student, currentClass: EBAClass, station: Int) {
        super.init(frame: .zero)
        self.student = student
        self.currentClass = currentClass
        self.station = station
        configureUI()
    }
    
    func configureUI () {
        configureHeaderLabel()
        configureNameLabel()
        configureFinishButton()
        configureAVPlayer()
    }
    
    func configureHeaderLabel () {
        headerLabel = EBATitleLabel(textAlignment: .center, fontSize: 50)
        headerLabel.numberOfLines = 0
        headerLabel.text = "Workout of the Day for \(student.name)"
        self.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 200),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -200),
            headerLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureNameLabel () {
        nameLabel = EBATitleLabel(textAlignment: .center, fontSize: 50)
        nameLabel.numberOfLines = 0
        nameLabel.text = "Exercise Name"
        self.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 200),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -200),
            nameLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureFinishButton () {
        finishButton = EBAButton(backgroundColor: Colors.red, title: "Finish Workout")
        finishButton.titleLabel?.font = UIFont(name: Fonts.liberator, size: 40)
        self.addSubview(finishButton)
        
        NSLayoutConstraint.activate([
            finishButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            finishButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 200),
            finishButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -200),
            finishButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
    }

    func configureAVPlayer() {
        
        
        let videoPlayer = UIView(frame: .zero)
        
        
        self.addSubview(videoPlayer)
        videoPlayer.translatesAutoresizingMaskIntoConstraints = false
        videoPlayer.backgroundColor = .white
        let backgroundImage = UIImageView(frame: videoPlayer.bounds)
        backgroundImage.contentMode =  .scaleAspectFit
        videoPlayer.insertSubview(backgroundImage, at: 0)
        NSLayoutConstraint.activate([
            videoPlayer.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            videoPlayer.bottomAnchor.constraint(equalTo: finishButton.topAnchor, constant: -30),
            videoPlayer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 200),
            videoPlayer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -200)
        ])
        
        let playerView =  EBAPlayerView()
        videoPlayer.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: videoPlayer.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: videoPlayer.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: videoPlayer.widthAnchor, multiplier: 16/9),
            playerView.centerYAnchor.constraint(equalTo: videoPlayer.centerYAnchor)
        ])
        let fileManager = FileManager.default
        let documentDir = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let localFile = documentDir.appendingPathComponent("downloadedVid.mov")
        let storageRef = Storage.storage().reference(withPath: "Quick Feet.mov")
        storageRef.write(toFile: localFile) { (url, error) in
            if let error = error {
                print("error: \(error.localizedDescription)")
                return
            }
            if let url = url {
                self.videoURL = url
                playerView.play(with: self.videoURL)

            }
        }
    }
    
    @objc func dismissKeyboard () {
        self.endEditing(true)
    }
    
}
