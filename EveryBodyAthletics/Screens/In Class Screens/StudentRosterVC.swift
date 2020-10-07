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
    
    var currentClass: EBAClass!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Student>!
    var station: Int!
    var editButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureDataSource()
        configureEditButton()
        updateData(currentClass: currentClass)
        title = "Students"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureEditButton () {
        editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editPressed))
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func editPressed () {
        var editClassVC = EditClassVC()
        editClassVC.currentClass = currentClass
        navigationController?.pushViewController(editClassVC, animated: true)
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
        let remainingSpace = width - edgeInsets * 2 - minimumSpaceBetween * 3
        let eachWidth = remainingSpace / 4
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: edgeInsets, left: edgeInsets, bottom: edgeInsets, right: edgeInsets)
        flowLayout.itemSize = CGSize(width: eachWidth, height: eachWidth + 40)
        
        return flowLayout
    }
    
    func configureDataSource () {
        dataSource = UICollectionViewDiffableDataSource<Section,Student>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, student) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EBAStudentCell.reuseID, for: indexPath) as! EBAStudentCell
            cell.set(student: student)
            return cell
        })
    }
    
    func updateData (currentClass: EBAClass) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Student>()
        snapshot.appendSections([.main])
        snapshot.appendItems(currentClass.students)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
}

extension StudentRosterVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let convStartVC = ConvStartVC()
        convStartVC.student = currentClass.students[indexPath.item]
        convStartVC.currentClass = currentClass
        convStartVC.station = station
        navigationController?.pushViewController(convStartVC, animated: true)
    }
}
