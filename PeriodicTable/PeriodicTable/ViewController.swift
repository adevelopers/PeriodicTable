//
//  ViewController.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 19.09.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit

class ViewModel {
    
    var info: String?

}

class ViewController: UIViewController {

    @IBOutlet weak var buttonSend: UIButton!

    let myNotification = Notification.Name(rawValue:"MoePoslanie")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapOnButtonSend = UITapGestureRecognizer(target: self, action: #selector(onButtonSendTap))
        buttonSend.addGestureRecognizer(tapOnButtonSend)
        
        configureNotifications()
    }

}

extension ViewController {
    
    func onButtonSendTap(sender: UIGestureRecognizer) {
        let nc = NotificationCenter.default
        let model = ViewModel()
        model.info = "Super puper!!!"
        
        nc.post(name: myNotification,
                object: nil,
                userInfo:["model": model ])
    }
    
    func configureNotifications() {
        let nc = NotificationCenter.default
        nc.addObserver(forName: myNotification, object: nil, queue: nil, using: catchMyNotification)
    }
    
    func catchMyNotification(notification: Notification) -> Void  {
        guard
            let userInfo = notification.userInfo,
            let model = userInfo["model"] as? ViewModel
        else {
            return
        }
        
        let alert = UIAlertController(title: "info", message: model.info ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
        print("catch Moe poslanie: \(model.info ?? "")\n")
        
    }
    
}
