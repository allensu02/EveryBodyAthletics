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
    
    var stackView: UIStackView!
    var dayStackViews: [UIStackView] = []
    var dayTableViews: [UITableView] = []
    var classes: [[EBAClass]] = [[], []]
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
        configureStackView()
        updateClasses()
    }
    
    func configure() {
        view.backgroundColor = .systemBackground
        
        sections = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
        configureNavButtons()
        title = "Classes"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.red, NSAttributedString.Key.font: UIFont(name: Fonts.liberator, size: 40)!]
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: Colors.red,
             NSAttributedString.Key.font: UIFont(name: Fonts.liberator, size: 60)!]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func configureStackView() {
        for day in DayInWeek.allCases {
            let dayStackView = configureVerticalStackView(day: day)
            dayStackViews.append(dayStackView)
        }
        stackView = UIStackView(arrangedSubviews: dayStackViews)
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
    }
    
    func configureVerticalStackView(day: DayInWeek) -> UIStackView {
        let label = EBATitleLabel(textAlignment: .center, fontSize: 50)
        let tableView = configureTableView()
        switch day {
        case .monday:
            label.text = "Mon"
            tableView.tag = 0
        case .tuesday:
            label.text = "Tue"
            tableView.tag = 1
        case .wednesday:
            label.text = "Wed"
            tableView.tag = 2
        case .thursday:
            label.text = "Thu"
            tableView.tag = 3
        case .friday:
            label.text = "Fri"
            tableView.tag = 4
        case .saturday:
            label.text = "Sat"
            tableView.tag = 5
        case .sunday:
            label.text = "Sun"
            tableView.tag = 6
        }
        dayTableViews.append(tableView)
        let stackView = UIStackView(arrangedSubviews: [label, tableView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }
    
    func configureTableView () -> UITableView{
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 200
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EBAClassCell.self, forCellReuseIdentifier: EBAClassCell.reuseID)
        tableView.reloadData()
        return tableView
    }
    
    func updateClasses () {
        getClasses { (returnedClasses) in
            
            self.classes = returnedClasses
            self.reloadTableViews()
        }
    }
    
    func reloadTableViews () {
        for tableView in dayTableViews {
            tableView.reloadData()
        }
    }
    
    func configureNavButtons () {
        let addExerciseButton = UIBarButtonItem(title: "Add Exercise", style: .plain, target: self, action: #selector(addExercisePressed))
        addExerciseButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: Fonts.liberator, size: 30)!], for: .normal)
        addExerciseButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: Fonts.liberator, size: 30)!], for: .highlighted)
        let addQuestionButton = UIBarButtonItem(title: "Add Question", style: .plain, target: self, action: #selector(addQuestionPressed))
        addQuestionButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: Fonts.liberator, size: 30)!], for: .normal)
        addQuestionButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: Fonts.liberator, size: 30)!], for: .highlighted)

        navigationItem.rightBarButtonItems = [addQuestionButton, addExerciseButton]
    }
    
    @objc func addExercisePressed () {
        let addWorkoutVC = AddWorkoutVC()
        addWorkoutVC.station = self.station
        navigationController?.pushViewController(addWorkoutVC, animated: true)
    }
    
    @objc func addQuestionPressed () {
        let addQuestionVC = AddQuestionVC()
        addQuestionVC.station = self.station
        navigationController?.pushViewController(addQuestionVC, animated: true)
    }
}

extension ClassesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(classes)
        switch tableView.tag{
        case 0: return classes[0].count
        case 1: return classes[1].count
//        case 2:
//        case 3:
//        case 4:
//        case 5:
//        case 6:
        default: return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EBAClassCell.reuseID, for: indexPath) as! EBAClassCell
        cell.selectionStyle = .none
        cell.clear()
        
        cell.setClass(cellClass: classes[indexPath.section][indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentRosterVC = StudentRosterVC()
        studentRosterVC.currentClass = classes[indexPath.section][indexPath.row]
        studentRosterVC.station = station
        navigationController?.pushViewController(studentRosterVC, animated: true)
    }
    
    
    
}
