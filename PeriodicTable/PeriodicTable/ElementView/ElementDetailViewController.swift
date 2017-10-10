//
//  ElementDetailViewController.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 09.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {

    var viewModel: ElementTableModel!
    var labelSymbol: UILabel!
    var labelNumber: UILabel!
    var buttonInformation: UIButton!
    
    var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    convenience init(model: ElementTableModel) {
        self.init(nibName: "ElementDetailViewController", bundle: nil)
        self.viewModel = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureRadialGradient()
        configureBackButton()
        configureElementView()
    }
    
}

extension ElementDetailViewController {
    
    fileprivate func configureRadialGradient() {
        view.backgroundColor = .black
        var frameForGradient = UIScreen.main.bounds
        frameForGradient.origin.y = -20
        let gradient = RadialGradientView(frame: frameForGradient)
        gradient.alpha = 0.8
        view.addSubview(gradient)
    }

    fileprivate func configureBackButton() {
        
        title = "Element Detail Infomation"
        self.navigationController?.navigationBar.topItem?.titleView?.tintColor = .white
        let backButton = UIBarButtonItem()
        backButton.setTitlePositionAdjustment(UIOffset.zero, for: .compact)
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    fileprivate func configureElementView() {
        labelSymbol = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 60))
        labelSymbol.textAlignment = .center
        labelSymbol.text = viewModel.symbol
        labelSymbol.font = UIFont(name: "American Typewriter", size: 50)
        labelSymbol.textColor = .white
        labelSymbol.center = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        view.addSubview(labelSymbol)
        
        labelNumber = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 30))
        labelNumber.textAlignment = .center
        labelNumber.text = "\(viewModel.number ?? 0)"
        labelNumber.font = UIFont(name: "American Typewriter", size: 30)
        labelNumber.textColor = .white
        labelNumber.center = CGPoint(x: screenSize.width/2 - 50, y: screenSize.height/2 - 50)
        view.addSubview(labelNumber)
        buttonInformation = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        buttonInformation.contentVerticalAlignment = .center
        buttonInformation.setTitle("i", for: .normal)
        buttonInformation.layer.borderColor = UIColor.white.cgColor
        buttonInformation.layer.borderWidth = 2
        buttonInformation.layer.cornerRadius = 10
        buttonInformation.center = CGPoint(x: screenSize.width/2+70, y: screenSize.height/2 - 50)
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapInfo(sender:)))
        buttonInformation.addGestureRecognizer(tap)
        view.addSubview(buttonInformation)
    }
    
    func onTapInfo(sender: Any) {
        let alert = UIAlertController(title: "info", message: "Information of element", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
