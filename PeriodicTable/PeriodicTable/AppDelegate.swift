//
//  AppDelegate.swift
//  PeriodicTable
//
//  Created by Kirill Khudyakov on 19.09.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit
import Bugsee

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().backgroundColor = UIColor.black
        UINavigationBar.appearance().tintColor = .white
        
        // отключаем стрелку с кнопки назад и потом поставим свою
        UINavigationBar.appearance().backIndicatorImage = #imageLiteral(resourceName: "button-back")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage()
        
        Bugsee.launch(token :"13545456-68eb-43c2-b564-bfdeb167d37a")
        
        return true
    }

}
