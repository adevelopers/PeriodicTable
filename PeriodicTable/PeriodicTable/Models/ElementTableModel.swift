//
//  ElementTableModel.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 01.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import Foundation


/// Модель элемента таблицы Менделеева
class ElementTableModel {
    
    dynamic var symbol = ""
    dynamic var name = ""
    dynamic var number =  0
    
    init(symbol: String, name: String, number: Int) {
        self.symbol = symbol
        self.name = name
        self.number = number
    }
    
    
}
