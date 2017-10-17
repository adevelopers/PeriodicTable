//
//  ElementCollectionViewCell.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 15.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit

class ElementCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelSymbol: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelSymbol.textColor = .white
        labelNumber.textColor = .white
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }

}
