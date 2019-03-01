//
//  ElementDetailViewController.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 09.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit


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

        electronConfig.text = "Config: " + viewModel.electronConfig
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
        elementImageView.translatesAutoresizingMaskIntoConstraints = false
        elementImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        elementImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        elementImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        elementImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 114).isActive = true

        labelSymbol.translatesAutoresizingMaskIntoConstraints = false
        labelSymbol.topAnchor.constraint(equalTo: elementImageView.bottomAnchor, constant: 30).isActive = true
        labelSymbol.widthAnchor.constraint(equalToConstant: 100).isActive = true
        labelSymbol.heightAnchor.constraint(equalToConstant: 70).isActive = true
        labelSymbol.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        labelNumber.translatesAutoresizingMaskIntoConstraints = false
        labelNumber.widthAnchor.constraint(equalToConstant: 62).isActive = true
        labelNumber.heightAnchor.constraint(equalToConstant: 42).isActive = true
        labelNumber.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        labelNumber.rightAnchor.constraint(equalTo: labelSymbol.leftAnchor, constant: -10).isActive = true
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.widthAnchor.constraint(equalToConstant: 200).isActive = true
        labelName.heightAnchor.constraint(equalToConstant: 42).isActive = true
        labelName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelName.topAnchor.constraint(equalTo: labelSymbol.bottomAnchor, constant: 10).isActive = true
        
        labelMass.translatesAutoresizingMaskIntoConstraints = false
        labelMass.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 20).isActive = true
        labelMass.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        
        electronConfig.translatesAutoresizingMaskIntoConstraints = false
        electronConfig.topAnchor.constraint(equalTo: labelMass.bottomAnchor, constant: 10).isActive = true
        electronConfig.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        
        labelPeriod.translatesAutoresizingMaskIntoConstraints = false
        labelPeriod.topAnchor.constraint(equalTo: electronConfig.bottomAnchor, constant: 10).isActive = true
        labelPeriod.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        
        labelColumn.translatesAutoresizingMaskIntoConstraints = false
        labelColumn.topAnchor.constraint(equalTo: labelPeriod.bottomAnchor, constant: 10).isActive = true
        labelColumn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        
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
