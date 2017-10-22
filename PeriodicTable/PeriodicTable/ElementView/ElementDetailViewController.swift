//
//  ElementDetailViewController.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 09.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit
import Kingfisher

class ElementDetailViewController: UIViewController {

    var viewModel: ElementTableModel!
    var labelSymbol: UILabel!
    var labelNumber: UILabel!
    var labelName: UILabel!
    var buttonInformation: UIButton!
    var elementImageView: UIImageView!
    
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
        configureImageView()
    
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
        labelNumber.text = "\(viewModel.number)"
        labelNumber.font = UIFont(name: "American Typewriter", size: 30)
        labelNumber.textColor = .white
        labelNumber.center = CGPoint(x: screenSize.width/2 - 50, y: screenSize.height/2 - 50)
        view.addSubview(labelNumber)
        
        labelName = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 30))
        labelName.textAlignment = .center
        labelName.text = viewModel.name
        labelName.font = UIFont(name: "American Typewriter", size: 30)
        labelName.textColor = .white
        labelName.center = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 50)
        view.addSubview(labelName)
        
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

    fileprivate func configureImageView() {
        elementImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let url = URL(string: viewModel.imagePath)!
        elementImageView.kf.setImage(with: url)
        elementImageView.center = CGPoint(x: screenSize.width/2, y: screenSize.height/2 - elementImageView.frame.height - 30)
        elementImageView.layer.borderColor = UIColor.white.cgColor
        elementImageView.layer.borderWidth = 2
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapToImage(sender:)))
        elementImageView.addGestureRecognizer(tap)
        elementImageView.isUserInteractionEnabled = true
        
        view.addSubview(elementImageView)
        
    }
    
}

    
    func onTapInfo(sender: Any) {
        let alert = UIAlertController(title: "info", message: "Information of element", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
