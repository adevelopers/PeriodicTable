//
//  AppDelegate.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 19.09.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        UINavigationBar.appearance().backgroundColor = UIColor.black
        UINavigationBar.appearance().tintColor = .white
        
        // отключаем стрелку с кнопки назад и потом поставим свою
        UINavigationBar.appearance().backIndicatorImage = #imageLiteral(resourceName: "button-back")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage()

        return true
    }

}

