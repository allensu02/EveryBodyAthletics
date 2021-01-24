//
//  EditClassVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/8/10.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class EditClassVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var currentClass: EBAClass!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Student>!
    var station: Int!
    var editButton: UIBarButtonItem!
    
    override func viewWillDisappear(_ animated: Bool) {
        if let vcs = self.navigationController?.viewControllers {
            let previousVC = vcs[vcs.count - 1]
            if previousVC is StudentRosterVC {
                let prevVC = previousVC as? StudentRosterVC
                prevVC?.currentClass = currentClass
                prevVC?.updateData(currentClass: currentClass)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureDataSource()
        configureAddButton()
        updateData(currentClass: currentClass)
        title = "Edit Class"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureAddButton() {
        let addButton = UIBarButtonItem(title: "Add Student", style: .done, target: self, action: #selector(addPressed))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addPressed () {
        let newStudentVC = NewStudentVC()
        newStudentVC.currentClass = currentClass
        navigationController?.pushViewController(newStudentVC, animated: true)
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
    func updateClass () {
        getClasses { (returnedClasses) in
            var index = 0
            switch self.currentClass.day {
            case .monday: index = 0
            case .tuesday: index = 1
            case .wednesday: index = 2
            case .thursday: index = 3
            case .friday: index = 4
            case .saturday: index = 5
            case .sunday: index = 6
            }
            for returnedClass in returnedClasses[index] {
                if self.currentClass.startTime == returnedClass.startTime {
                    self.currentClass = returnedClass
                    print(self.currentClass.students)
                    DispatchQueue.main.async {
                        self.updateData(currentClass: self.currentClass)
                    }
                }
            }
            
        }
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

extension EditClassVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let editStudentVC = EditStudentVC()
        editStudentVC.student = currentClass.students[indexPath.item]
        editStudentVC.currentClass = currentClass
        navigationController?.pushViewController(editStudentVC, animated: true)
    }
} 
