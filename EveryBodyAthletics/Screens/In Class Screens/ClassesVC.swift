//
//  ClassesVC.swift
//  EveryBodyAthletics
//
//  Created by Allen Su on 2020/7/23.
//  Copyright © 2020 Allen Su. All rights reserved.
//

import UIKit

class ClassesVC: UIViewController {
    
    var tableView: UITableView!
    var classes: [Class] = []
    var sections: [DayInWeek] = []
    var station: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getClasses()
        configureTableView()
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
        //        NSLayoutConstraint.activate([
        //            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
        //            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        //            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        //            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        //        ])
    }
    
    func getClasses () {
        var firstClass = Class(day: .monday, time: "10:30 - 11:15", students: [Student(name: "John A.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "Brendan B.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon)], docID: "fowejifoweji")
        var secondClass = Class(day: .monday, time: "12:45 - 1:30", students: [Student(name: "Allen A.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "Brendan B.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "Calvin C.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "David D.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "Elijah E.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "Frank F.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "Gary G.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "Howard H.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "Ishmael I.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "Jake J.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "Kevin K.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "Louis L.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "Milton M.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "Noah N.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon)], docID: "Soioij")
        classes = [firstClass, secondClass]
    }
}

extension ClassesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: EBAClassCell.reuseID, for: indexPath) as! EBAClassCell
        cell.selectionStyle = .none
        cell.clear()
        cell.setClass(cellClass: classes[indexPath.row])
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
        studentRosterVC.currentClass = classes[indexPath.row]
        studentRosterVC.station = station
        navigationController?.pushViewController(studentRosterVC, animated: true)
    }
    
    
    
}
