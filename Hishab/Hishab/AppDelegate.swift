//
//  AppDelegate.swift
//  Hishab
//
//  Created by Sajid Shanta on 22/2/24.
//

import UIKit
import IQKeyboardManager

//@main
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared().isEnabled = true

        return true
    }
}

