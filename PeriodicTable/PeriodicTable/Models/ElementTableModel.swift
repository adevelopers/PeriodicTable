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
    
    @objc dynamic var symbol = ""
    @objc dynamic var name = ""
    @objc dynamic var number =  0
    
    @objc dynamic var electronConfig = ""
    @objc dynamic var category = ""
    @objc dynamic var period = 0
    @objc dynamic var group = 0
    @objc dynamic var valence = 0
    @objc dynamic var electronegativity: Double = 0
    @objc dynamic var mass: Double = 0

    var imagePath: String {
        return "http://images-of-elements.com/s/" + name.lowercased() + ".jpg"
    }
    
    init(symbol: String, name: String, number: Int) {
        self.symbol = symbol
        self.name = name
        self.number = number
    }
    
}
