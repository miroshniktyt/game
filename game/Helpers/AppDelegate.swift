//
//  AppDelegate.swift
//  PaintBall
//
//  Created by Taras Kolesnyk on 17.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Settings.shared.setDarkMode()

        return true
    }
    
}
