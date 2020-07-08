//
//  ExerciseVideoVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/5.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import AVFoundation
import AVKit

class ExerciseVideoVC: EBADataLoadingVC {
    
    var exercise: Exercise!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print(exercise.name)
        getVideoFile()
    }
    
    func getVideoFile () {
        let storage = Storage.storage()
        let referenceUrl = "gs://everybodyathletics.appspot.com/" + exercise.videoLink
        // Create a reference to the file you want to download
        let gsReference = storage.reference(forURL: referenceUrl)
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        
        // Fetch the download URL
        gsReference.downloadURL { url, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.playVideo(url: url!)
            }
        }
        
    }
    
    func playVideo (url: URL) {
        let videoURL = url
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
    }
    
    
}
