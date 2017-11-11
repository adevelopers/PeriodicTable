//
//  PeriodicTableService.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 01.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import Foundation

class PeriodicTableService {
    
    func loadElements(from fileName: String) -> [ElementTableModel] {
        var arElements = [ElementTableModel]()
        
        do {
            if let file = Bundle.main.url(forResource: fileName, withExtension: "json") {
                let data = try Data(contentsOf: file)
                
                if
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let elements = json["elements"] as? [[String: Any]]
                {
                    for element in elements {
                        
                        let model = ElementTableModel(symbol: (element["symbol"] as? String) ?? "",
                                                      name: (element["name"] as? String) ?? "",
                                                      number: (element["number"] as? Int) ?? 0)
                        
                        model.category = element["category"] as? String ?? ""
                        model.electronConfig = element["electronConfig"] as? String ?? ""
                        model.mass = element["molar"] as? Double ?? 0
                        model.electronegativity  = element["electronegativity"] as? Double ?? 0
                        
                        model.group = element["group"] as? Int ?? 0
                        model.period = element["period"] as? Int ?? 0
                        
                        arElements.append(model)
                    }
                }
                
            }
        } catch {
            print("\(#function) -> error json")
        }
        
        return arElements
    }
    
    func getPeriodicTable() -> PeriodicTableModel {
        return PeriodicTableModel(elements: loadElements(from: "table"))
    }
    
}
