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
    
    init(elements: [ElementTableModel]) {
        list.append(contentsOf: elements)
    }
    
}

extension PeriodicTableModel {
    
    func element(at index: Int) -> ElementTableModel? {
        if index < list.count {
            return list[index]
        } else {
            return nil
        }
    }
    
}
