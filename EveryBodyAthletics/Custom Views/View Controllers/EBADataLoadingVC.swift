//
//  EBADataLoadingVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/3.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class EBADataLoadingVC: UIViewController {

    var containerView: UIView!
    
    //pop ups a loading screen
    func showLoadingView () {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    //dismisses loading screen
    func dismissLoadingView () {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
}
