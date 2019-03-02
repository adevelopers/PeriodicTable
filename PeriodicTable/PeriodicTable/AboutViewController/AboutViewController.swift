//
//  AboutViewController.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 10.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    var textView: UITextView!
    var viewModel: AboutViewModel?
    
    var size: CGSize {
        return UIScreen.main.bounds.size
    }
    
    convenience init(model: AboutViewModel) {
        self.init(nibName: "AboutViewController", bundle: nil)
        viewModel = model
        title = "About"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackButton()
        configureRadialGradient()

        textView = UITextView(frame: .zero)
        view.addSubview(textView)
        textView.text = viewModel?.text ?? ""
        textView.textColor = .white
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(top: 80,
                                                   left: 30,
                                                   bottom: 30,
                                                   right: 30)
        textView.font = UIFont(name: "Arial", size: 14)
        textView.alpha = 0.6
        
        setupConstrainsts()
    }
    
    
    fileprivate func configureRadialGradient() {
        view.backgroundColor = .black
        var frameForGradient = UIScreen.main.bounds
        frameForGradient.origin.y = -20
        let gradient = RadialGradientView(frame: frameForGradient)
        gradient.alpha = 0.8
        view.addSubview(gradient)
    }
    
    fileprivate func configureBackButton() {
        self.navigationController?.navigationBar.topItem?.titleView?.tintColor = .white
        let backButton = UIBarButtonItem()
        backButton.setTitlePositionAdjustment(UIOffset.zero, for: .compact)
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    func setupConstrainsts() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        textView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
    

}
