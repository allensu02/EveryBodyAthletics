//
//  StudentRosterVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/26.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class StudentRosterVC: UIViewController {

    enum Section {
        case main
    }
    
    var students: [Student] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Student>!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureDataSource()
        updateData(students: students)
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout(view: view))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(EBAStudentCell.self, forCellWithReuseIdentifier: EBAStudentCell.reuseID)
    }

    func createThreeColumnFlowLayout (view: UIView) -> UICollectionViewFlowLayout {
        //calculation to find width of each item
        let width = view.bounds.width
        let edgeInsets: CGFloat = 12
        let minimumSpaceBetween: CGFloat = 10
        let remainingSpace = width - edgeInsets * 2 - minimumSpaceBetween * 2
        let eachWidth = remainingSpace / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: edgeInsets, left: edgeInsets, bottom: edgeInsets, right: edgeInsets)
        flowLayout.itemSize = CGSize(width: eachWidth, height: eachWidth + 40)
        
        return flowLayout
    }
    
    func configureDataSource () {
        dataSource = UICollectionViewDiffableDataSource<Section,Student>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, student) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EBAStudentCell.reuseID, for: indexPath) as! EBAStudentCell
            
            return cell
        })
    }
    
    func updateData (students: [Student]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Student>()
        snapshot.appendSections([.main])
        snapshot.appendItems(students)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
}

extension StudentRosterVC: UICollectionViewDelegate {
    
}
