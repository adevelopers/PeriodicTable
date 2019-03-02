//
//  RadialGradientView.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 06.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit

class RadialGradientView: UIView {
    
    override func draw(_ rect: CGRect) {
        let colors = [#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor, UIColor.clear.cgColor]
        
        if
            let context = UIGraphicsGetCurrentContext(),
            let gradient = CGGradient(colorsSpace: nil, colors: colors as CFArray, locations: nil)
        {
            context.drawRadialGradient( gradient, startCenter: center,
                                        startRadius: 0,
                                        endCenter: center,
                                        endRadius: frame.height / 1.5, options: CGGradientDrawingOptions.drawsAfterEndLocation)
        }
    }
    
}
