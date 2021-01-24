//
//  EBAStudentCell.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/26.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import FirebaseStorage
class EBAStudentCell: UICollectionViewCell {
    static let reuseID = "StudentCell"
    
    var profileImageView = EBAProfileImageView(frame: .zero)
    let usernameLabel = EBATitleLabel(textAlignment: .center, fontSize: 35)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(student: Student) {
        usernameLabel.textColor = .black
        usernameLabel.text = student.name
        getImage { (image) in
            self.profileImageView.image = image
        }
        configure()
    }
    
    func getImage(onCompletion: @escaping (UIImage) -> Void) {
        let storageRef = Storage.storage().reference(withPath: "defaultGuyIcon.png")
        storageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
            if let error = error {
                print("got error \(error.localizedDescription)")
                return
            }
            if let data = data {
                onCompletion(UIImage(data: data)!)
            }
        }
    }
    
    private func configure() {
        addSubviews(profileImageView, usernameLabel)

        configureAvatarImageView()
        configureUsernameLabel()
    }
    
    private func configureAvatarImageView () {
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor)
        ])
    }
    
    private func configureUsernameLabel () {
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
