//
//  ClassesVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/23.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit
import Firebase

class ClassesVC: UIViewController {
    
    var tableView: UITableView!
    var classes: [[EBAClass]] = [[]]
    var sections: [DayInWeek] = []
    var station: Int!
    let db = Firestore.firestore()
    var students: [Student] = []
    
    override func viewWillAppear(_ animated: Bool) {
        updateClasses()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
        updateClasses()
    }
    
    func configure() {
        view.backgroundColor = .systemBackground
        
        sections = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
        
        title = "Classes"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.red, NSAttributedString.Key.font: UIFont(name: Fonts.liberator, size: 40)]
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: Colors.red,
             NSAttributedString.Key.font: UIFont(name: Fonts.liberator, size: 60)]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func configureTableView () {
        tableView = UITableView(frame: view.bounds)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EBAClassCell.self, forCellReuseIdentifier: EBAClassCell.reuseID)
        tableView.reloadData()
        
    }
    
    func updateClasses () {
        getClasses { (returnedClasses) in
            self.classes = returnedClasses
            self.tableView.reloadData()
        }
    }
    
}

extension ClassesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section{
        case 0: return classes[0].count
//        case 1: return classes[1].count
//        case 2: return classes[2].count
//        case 3: return classes[3].count
//        case 4: return classes[4].count
//        case 5: return classes[5].count
//        case 6: return classes[6].count
        default: return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: EBAClassCell.reuseID, for: indexPath) as! EBAClassCell
        cell.selectionStyle = .none
        cell.clear()
        
        cell.setClass(cellClass: classes[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < sections.count {
            return sections[section].rawValue
        }
        
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        
        let label = EBATitleLabel(textAlignment: .left, fontSize: 50)
        label.text = sections[section].rawValue
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var studentRosterVC = StudentRosterVC()
        studentRosterVC.currentClass = classes[indexPath.section][indexPath.row]
        studentRosterVC.station = station
        navigationController?.pushViewController(studentRosterVC, animated: true)
    }
    
    
    
}
