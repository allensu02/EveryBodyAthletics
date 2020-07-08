//
//  ExercisesVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/6/26.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import Firebase

class ExercisesVC: EBADataLoadingVC {

    var tableView: UITableView!
    var sections = ["Warm Up", "Circuit", "Cooldown"]
    var warmUpExercises: [Exercise] = []
    var circuitExercises: [Exercise] = []
    var cooldownExercises: [Exercise] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getExercises()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "This Week's Exercises"
        configureTableView()
    }
    
    func configureTableView () {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.rowHeight = 140
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EBAExerciseCell.self, forCellReuseIdentifier: EBAExerciseCell.reuseID)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func getExercises () {
        showLoadingView()
        self.warmUpExercises.removeAll()
        self.circuitExercises.removeAll()
        self.cooldownExercises.removeAll()
        let db = Firestore.firestore()
        let exercises = db.collection("exercises").getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents {
                    let name = document["name"] as! String
                    let type = document["type"] as! String
                    let videoURL = document["videoURL"] as! String
                    let image = UIImage(named: "jumpingjack")!
                    
                    let newExercise = Exercise(name: name, type: type, videoLink: videoURL, image: image)
                    
                    switch type {
                    case "warmUp": self.warmUpExercises.append(newExercise)
                    case "circuit": self.circuitExercises.append(newExercise)
                    case "cooldown": self.cooldownExercises.append(newExercise)
                    default: self.warmUpExercises.append(newExercise)
                    }
                }
                
                self.tableView.reloadData()
                self.dismissLoadingView()
            }
        }
    }
}

extension ExercisesVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return warmUpExercises.count
        case 1:
            return circuitExercises.count
        case 2:
            return cooldownExercises.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: EBAExerciseCell.reuseID, for: indexPath) as! EBAExerciseCell
        
        var exercise =  Exercise(name: "", type: "warmUp", videoLink: "", image: UIImage())
        switch indexPath.section {
        case 0:
            exercise = warmUpExercises[indexPath.row]
        case 1:
            exercise = circuitExercises[indexPath.row]
        case 2:
            exercise = cooldownExercises[indexPath.row]
        default:
            exercise = warmUpExercises[indexPath.row]
        }
        cell.setExercise(exercise: exercise)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < sections.count {
            return sections[section]
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        
        let label = EBATitleLabel(textAlignment: .left, fontSize: 35)
        label.text = sections[section]
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exerciseVideoVC = ExerciseVideoVC()
        switch indexPath.section {
        case 0: exerciseVideoVC.exercise = warmUpExercises[indexPath.row]
        case 1: exerciseVideoVC.exercise = circuitExercises[indexPath.row]
        case 2: exerciseVideoVC.exercise = cooldownExercises[indexPath.row]
        default: exerciseVideoVC.exercise = warmUpExercises[indexPath.row]
        }
        navigationController?.pushViewController(exerciseVideoVC, animated: true)
    }
    
}
