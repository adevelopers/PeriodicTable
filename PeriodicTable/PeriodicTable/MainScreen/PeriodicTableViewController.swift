//
//  PeriodicTableViewController.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 01.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit

class RadialGradientView: UIView {
    
    override func draw(_ rect: CGRect) {
        let colors = [#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor, UIColor.clear.cgColor]
        
        if let context = UIGraphicsGetCurrentContext(),
           let gradient = CGGradient(colorsSpace: nil, colors: colors as CFArray, locations: nil)
        {
            context.drawRadialGradient( gradient, startCenter: center,
                                        startRadius: 0,
                                        endCenter: center,
                                        endRadius: frame.height/1.5, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        }
    }
    
}

class PeriodicTableViewController: UIViewController {

    var tableView: UITableView!
    
    var model: PeriodicTableModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        var frameForGradient = view.frame
        frameForGradient.origin.y = -20
        let gradient = RadialGradientView(frame: frameForGradient)
        gradient.alpha = 0.8
        view.addSubview(gradient)
        
        model = PeriodicTableService().getPeriodicTable()
        
        tableView = UITableView(frame: view.frame)
        tableView.dataSource = self
        tableView.backgroundColor = .clear

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
        cell.textLabel?.textColor = .white
        cell.textLabel?.alpha = 0.5
        cell.backgroundColor = .clear
        return cell
    }
    
}
