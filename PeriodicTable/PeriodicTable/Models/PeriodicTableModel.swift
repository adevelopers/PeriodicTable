//
//  PeriodicTableModel.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 01.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import Foundation


class PeriodicTableModel {
    
    var list = [ElementTableModel]()
    var filterCriteria: String?
    
    init(elements: [ElementTableModel]) {
        list.append(contentsOf: elements)
    }
    
    var filteredList: [ElementTableModel] {
        guard let filterCriteria = filterCriteria else {
            return list
        }
        
        if let number = Int(filterCriteria), number > 0 {
            return list.filter { $0.number == number }
        }
        
        if filterCriteria.characters.count > 2 {
            return list.filter { $0.name.lowercased().contains(filterCriteria.lowercased()) }
        }
        
        return list.filter { $0.symbol.lowercased().contains(filterCriteria.lowercased()) }
    }
    
}

extension PeriodicTableModel {
    
    func element(at index: Int) -> ElementTableModel? {
        if index < filteredList.count {
            return filteredList[index]
        } else {
            return nil
        }
    }
    
}
