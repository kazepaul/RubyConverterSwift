//
//  RCLevelListViewController.swift
//  RubyConverterSwift
//
//  Created by Chan, Paul | Paul | PAYSD on 2019/05/25.
//  Copyright © 2019年 Chan Ka Ho, Paul. All rights reserved.
//

import UIKit


protocol RCGradeListViewDelegate {
    func didGradeSelected(_ grade: Grade)
}

class RCGradeListViewController: UITableViewController {
    fileprivate let cellIdentifier = "GradeCell"
    
    var delegate:RCGradeListViewDelegate?

    let gradeArray = Grade.allCases()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
    }
    
    func setupUI() {
        title = "変換レベル設定"
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gradeArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = gradeArray[indexPath.row].gradeDescription()
        cell.textLabel?.numberOfLines = 0
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didGradeSelected(Grade.allCases()[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}
