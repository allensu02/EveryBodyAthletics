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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        getClasses()
        configureTableView()
    }
    
    func configureTableView () {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EBAClassCell.self, forCellReuseIdentifier: EBAClassCell.reuseID)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func getClasses () {
        var firstClass = Class(day: .monday, time: "10:30 - 11:15", students: [Student(name: "John A.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "Brendan B.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon)])
        var secondClass = Class(day: .monday, time: "10:30 - 11:15", students: [Student(name: "John A.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon), Student(name: "Brendan B.", physLevel: .a, socialLevel: .b, faceImage: Images.userIcon)])
        classes = [firstClass, secondClass]
    }
}

extension ClassesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: EBAClassCell.reuseID, for: indexPath) as! EBAClassCell
        
        cell.setClass(cellClass: classes[indexPath.row])
        return cell
    }
    
    
}
