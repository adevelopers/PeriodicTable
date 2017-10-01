//
//  PeriodicTableViewController.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 01.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit

class PeriodicTableViewController: UIViewController {

    var tableView: UITableView!
    
    var model: PeriodicTableModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        model = PeriodicTableService().getPeriodicTable()
        
        tableView = UITableView(frame: view.frame)
        tableView.dataSource = self
        view.addSubview(tableView)
    }

}

extension PeriodicTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "defaultCell")
        cell.textLabel?.text = model.elements[indexPath.row].name ?? ""
        return cell
    }
    
}
