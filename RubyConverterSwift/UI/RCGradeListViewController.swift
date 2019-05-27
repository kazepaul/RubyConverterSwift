//
//  RCLevelListViewController.swift
//  RubyConverterSwift
//
//  Created by Chan, Paul | Paul | PAYSD on 2019/05/25.
//  Copyright © 2019年 Chan Ka Ho, Paul. All rights reserved.
//

import UIKit

protocol RCGradeListViewDelegate {
    func gradeListView(_ listView:RCGradeListViewController, didSelectGrade grade: Grade)
}

class RCGradeListViewController: UITableViewController {
    fileprivate let cellIdentifier = "GradeCell"
    
    var delegate: RCGradeListViewDelegate?

    private let dataSource = Grade.allCases()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
    }
    
    // MARK: - Setup UI
    func setupUI() {
        title = "変換レベル設定"
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = dataSource[indexPath.row].description()
        cell.textLabel?.numberOfLines = 0

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.gradeListView(self, didSelectGrade: dataSource[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}
