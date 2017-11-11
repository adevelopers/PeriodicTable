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
    
    dynamic var electronConfig = ""
    dynamic var category = ""
    dynamic var period = 0
    dynamic var group = 0
    dynamic var valence = 0
    dynamic var electronegativity: Double = 0
    dynamic var mass: Double = 0

    var imagePath: String {
        return "http://images-of-elements.com/s/" + name.lowercased() + ".jpg"
    }
    
    init(symbol: String, name: String, number: Int) {
        self.symbol = symbol
        self.name = name
        self.number = number
    }
    
}
