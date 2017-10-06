//
//  MainCell.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 06.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {

    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var symbol: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        number.textColor = .white
        name.textColor = .white
        symbol.textColor = .white
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
}
