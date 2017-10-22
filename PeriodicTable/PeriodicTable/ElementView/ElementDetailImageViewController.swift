//
//  ElementDetailImageViewController.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 22.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit

class ElementDetailImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
   
    var viewModel: ElementTableModel?
    
    convenience init(model: ElementTableModel) {
        self.init(nibName: "ElementDetailImageViewController", bundle: nil)
        self.viewModel = model
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureBackButton()
        
        if let viewModel = viewModel {
            let url = URL(string: viewModel.imagePath)!
            imageView.kf.setImage(with: url)
        }
    }

    fileprivate func configureBackButton() {
        title = "Element Detail Image"
        self.navigationController?.navigationBar.topItem?.titleView?.tintColor = .white
        let backButton = UIBarButtonItem()
        backButton.setTitlePositionAdjustment(UIOffset.zero, for: .compact)
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}
