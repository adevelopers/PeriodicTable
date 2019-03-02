//
//  MainScreenCollectionViewController.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 14.10.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainScreenCollectionViewController: UIViewController {
    
    let bag = DisposeBag()
    
    var collectionView: UICollectionView!
    var searchController: UISearchController!
    var customSearchBar: UITextField!
    var model: PeriodicTableModel!
    
    var configuredLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 90)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        var frameForGradient = view.frame
        frameForGradient.origin.y = -20
        let gradient = RadialGradientView(frame: frameForGradient)
        gradient.alpha = 0.8
        view.addSubview(gradient)
        
        configureCollectionView()
        configureTitleView()
        configureSearchBar()

        let swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(onRightSwipe(event:)))
        view.addGestureRecognizer(swipeToRight)
        
        let tapToDimm = UITapGestureRecognizer(target: self, action: #selector(onTapToDimm(event:)))
        tapToDimm.cancelsTouchesInView = false
        collectionView.addGestureRecognizer(tapToDimm)
        
    }
    
    override func viewDidLayoutSubviews() {
        collectionView.contentOffset.y += 10
    }
    
    @objc func onRightSwipe(event: Any) {
        let aboutModel = AboutViewModel()
        let aboutViewController = AboutViewController(model: aboutModel)
        self.navigationController?.pushViewController(aboutViewController, animated: true)
    }
    
    @objc func onTapToDimm(event: Any) {
        customSearchBar.resignFirstResponder()
    }
    
}

extension MainScreenCollectionViewController {
    
    
    func configureTitleView() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.title = "Periodic Table"
    }
    
    func configureCollectionView() {
        model = PeriodicTableService().getPeriodicTable()
        
        let offset = (navigationController?.navigationBar.intrinsicContentSize.height ?? 0)
            + UIApplication.shared.statusBarFrame.height
            + 44
            + 24
        
        let frameCollectionView = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - offset)
        
        collectionView = UICollectionView(frame: frameCollectionView, collectionViewLayout: configuredLayout)
        collectionView.register(UINib(nibName: "ElementCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.center.y += offset
        view.addSubview(collectionView)
    }

    func configureSearchBar() {
        let offset = (navigationController?.navigationBar.intrinsicContentSize.height ?? 0)
            + UIApplication.shared.statusBarFrame.height
        customSearchBar = UITextField(frame: CGRect(x: 10, y: 10, width: view.frame.width - 20, height: 44))
        customSearchBar.textColor = .white
        customSearchBar.textAlignment = .center
        customSearchBar.layer.borderColor = UIColor.white.cgColor
        customSearchBar.layer.borderWidth = 1
        customSearchBar.center.y += offset
        view.addSubview(customSearchBar)

        customSearchBar.rx.text
            .orEmpty
            .debounce(0.2, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                if query.count > 0 {
                    self?.model.filterCriteria = query
                } else {
                    self?.model.filterCriteria = nil
                }
                self?.collectionView.reloadData()
            })
            .disposed(by: bag)
    }

    
}

extension MainScreenCollectionViewController: UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return model.filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell: ElementCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)  as? ElementCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = .clear
        if let element = model.element(at: indexPath.row) {
            cell.labelSymbol.text = element.symbol
            cell.labelSymbol.font = UIFont(name: "Arial", size: 45)
            cell.labelNumber.text = "\(element.number)"
        }
        return cell
    }

}

extension MainScreenCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let elementModel = model.element(at: indexPath.row) {
            let elementViewController = ElementDetailViewController(model: elementModel)
            self.navigationController?.pushViewController(elementViewController, animated: true)
        }
    }
    
}

extension MainScreenCollectionViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let count = searchController.searchBar.text?.count, count > 0{
            model.filterCriteria = searchController.searchBar.text
        }
        else {
            model.filterCriteria = nil
        }
        
        collectionView.reloadData()
    }
    
}
