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
    var searchController: UISearchController!
    var filtredResult: [ElementTableModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        var frameForGradient = view.frame
        frameForGradient.origin.y = -20
        let gradient = RadialGradientView(frame: frameForGradient)
        gradient.alpha = 0.8
        view.addSubview(gradient)
        
        configureTableView()
        configureTitleView()
        
        let swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(onRightSwipe(event:)))
        view.addGestureRecognizer(swipeToRight)
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    func onRightSwipe(event: Any) {
        let aboutModel = AboutViewModel()
        let aboutViewController = AboutViewController(model: aboutModel)
        self.navigationController?.pushViewController(aboutViewController, animated: true)
    }
    
}

extension PeriodicTableViewController {
    
    func configureTitleView() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationItem.title = "Periodic Table"
    }
 
    func configureTableView() {
        model = PeriodicTableService().getPeriodicTable()
        
        let offset = (navigationController?.navigationBar.intrinsicContentSize.height ?? 0)  + UIApplication.shared.statusBarFrame.height
        
        let frameTableView = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - offset)
        tableView = UITableView(frame: frameTableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.center.y += offset
        
        view.addSubview(tableView)
    }
    
    func configureSearchBar() {
        
    }
}

extension PeriodicTableViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ElementCell", owner: self, options: nil)?.first as! ElementCell
        
        if let element = model.element(at: indexPath.row) {
            cell.number.text = "\(element.number)"
            cell.name.text = element.name
            cell.symbol.text = element.symbol
        }

        return cell
    }
    
}

extension PeriodicTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let elementModel = model.element(at: indexPath.row) {
            let elementViewController = ElementDetailViewController(model: elementModel)
            self.navigationController?.pushViewController(elementViewController, animated: true)
        }
    }
    
}

// MARK: Search Bar
extension PeriodicTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let count = searchController.searchBar.text?.characters.count, count > 0{
            model.filterCriteria = searchController.searchBar.text
        }
        else {
            model.filterCriteria = nil
        }
        
        tableView.reloadData()
    }

}
