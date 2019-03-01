//
//  ElementDetailViewController.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 09.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit
//import SnapKit

class ElementDetailViewController: UIViewController {

    @IBOutlet weak var labelSymbol: UILabel!
    @IBOutlet weak var electronConfig: UILabel!
    @IBOutlet weak var labelPeriod: UILabel!
    @IBOutlet weak var labelColumn: UILabel!
    @IBOutlet weak var labelMass: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var elementImageView: UIImageView!
    
    var viewModel: ElementTableModel!
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
        configureImageView()
    
        setupConstaints()
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
        
        title = viewModel.name
        self.navigationController?.navigationBar.topItem?.titleView?.tintColor = .white
        let backButton = UIBarButtonItem()
        backButton.setTitlePositionAdjustment(UIOffset.zero, for: .compact)
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    fileprivate func configureElementView() {
        
        configureSymbol()
        configureNumber()
        configureName()
        configureButtonInformation()

        electronConfig.text = "Config: "+viewModel.electronConfig
        labelPeriod.text = "Period: \(viewModel.period)"
        labelColumn.text = "Column: \(viewModel.group)"
        labelMass.text = String(format: "Mass: %0.2f", viewModel.mass)
        
    }
    
    private func configureButtonInformation() {
        buttonInformation = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        buttonInformation.contentVerticalAlignment = .center
        buttonInformation.setTitle("i", for: .normal)
        buttonInformation.layer.borderColor = UIColor.white.cgColor
        buttonInformation.layer.borderWidth = 2
        buttonInformation.layer.cornerRadius = 10
        buttonInformation.center = CGPoint(x: screenSize.width/2+70, y: screenSize.height/2 - 50)
        buttonInformation.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapInfo(sender:)))
        buttonInformation.addGestureRecognizer(tap)
        view.addSubview(buttonInformation)
    }
    
    private func configureName() {
        labelName.textAlignment = .center
        labelName.text = viewModel.name
        labelName.font = UIFont(name: "American Typewriter", size: 30)
        labelName.textColor = .white
        labelName.center = CGPoint(x: screenSize.width/2, y: screenSize.height/2 + 50)
        view.addSubview(labelName)
    }
    
    private func configureSymbol() {
        labelSymbol.textAlignment = .center
        labelSymbol.text = viewModel.symbol
        labelSymbol.font = UIFont(name: "American Typewriter", size: 50)
        labelSymbol.textColor = .white
        labelSymbol.center = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        view.addSubview(labelSymbol)
    }
    
    private func configureNumber() {
        labelNumber.textAlignment = .center
        labelNumber.text = "\(viewModel.number)"
        labelNumber.font = UIFont(name: "American Typewriter", size: 30)
        labelNumber.textColor = .white
        labelNumber.center = CGPoint(x: screenSize.width/2 - 50, y: screenSize.height/2 - 50)
        view.addSubview(labelNumber)
    }
    
    private func checkImageExist(by path: String) -> Bool {
        let fm = FileManager.default
        return fm.fileExists(atPath: path)
    }

    fileprivate func configureImageView() {
        let elementImage = UIImage(named: viewModel.symbol)
        elementImageView.image = elementImage
        elementImageView.layer.borderColor = UIColor.white.cgColor
        elementImageView.layer.borderWidth = 2
        elementImageView.contentMode = .scaleAspectFit
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapToImage(sender:)))
        elementImageView.addGestureRecognizer(tap)
        elementImageView.isUserInteractionEnabled = true
        
        if elementImage == nil{
            elementImageView.isHidden = true
        }
        
        view.addSubview(elementImageView)
    }

    fileprivate func setupConstaints() {
        
        elementImageView.snp.makeConstraints { set in
            set.width.equalTo(100)
            set.height.equalTo(100)
            set.top.equalTo(114)
            set.centerX.equalToSuperview()
        }
        
        labelSymbol.snp.makeConstraints { set in
            set.top.equalTo(elementImageView.snp.bottom).offset(30)
            set.width.equalTo(100)
            set.height.equalTo(70)
            set.centerX.equalToSuperview()
        }
        
        labelNumber.snp.makeConstraints { set in
            set.width.equalTo(62)
            set.height.equalTo(42)
            set.centerY.equalTo(labelSymbol.snp.centerY)
            set.right.equalTo(labelSymbol.snp.left).offset(-10)
        }
        
        labelName.snp.makeConstraints { set in
            set.width.equalTo(200)
            set.height.equalTo(42)
            set.centerX.equalToSuperview()
            set.top.equalTo(labelSymbol.snp.bottom).offset(10)
        }
        
        labelMass.snp.makeConstraints { set in
            set.top.equalTo(labelName.snp.bottom).offset(20)
            set.left.equalToSuperview().offset(50)
        }
        
        electronConfig.snp.makeConstraints { set in
            set.top.equalTo(labelMass.snp.bottom).offset(10)
            set.left.equalToSuperview().offset(50)
        }
        
        labelPeriod.snp.makeConstraints { set in
            set.top.equalTo(electronConfig.snp.bottom).offset(10)
            set.left.equalToSuperview().offset(50)
        }
        
        labelColumn.snp.makeConstraints { set in
            set.top.equalTo(labelPeriod.snp.bottom).offset(10)
            set.left.equalToSuperview().offset(50)
        }
        
        
    }
    
}

extension ElementDetailViewController {
    
    @objc func onTapInfo(sender: Any) {
        let alert = UIAlertController(title: "info", message: "Information of element", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func onTapToImage(sender: Any) {
        let imageViewController = ElementDetailImageViewController(model: viewModel)
        self.navigationController?.pushViewController(imageViewController, animated: true)
    }
    
}
