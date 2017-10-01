//
//  PeriodicTableService.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 01.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import Foundation

class PeriodicTableService {
    
    fileprivate func getElements() -> [ElementTableModel] {
        
        var models = [ElementTableModel]()
        
        let elements = [
            ("H","Hydrogen",1),
            ("He","Helium",2),
            ("Li","Lithium",3),
            ("Ar","Argon",18),
            ("K","Potassium",19),
            ("Ca","Calcium",20),
            ("Og","Oganesson",118)
        ]
        
        elements.forEach{
            let element = ElementTableModel(symbol: $0.0, name: $0.1, number: $0.2)
            models.append(element)
        }
        
        return models
    }
    
    func getPeriodicTable() -> PeriodicTableModel {
        return PeriodicTableModel(elements: getElements())
    }
    
}
