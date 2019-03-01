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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().backIndicatorImage = #imageLiteral(resourceName: "button-back")
        UINavigationBar.appearance().backgroundColor = UIColor.black
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage()
        return true
    }
    

}
