//
//  AppDelegate.swift
//  iOS Auth Handling UIKit
//
//  Created by Scott Recker on 7/3/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var appNavCoordinator: AppNavCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        appNavCoordinator = AppNavCoordinator(window: window!)
        appNavCoordinator.start()

        return true
    }

}

