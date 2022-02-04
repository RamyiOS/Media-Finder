//
//  AppDelegate.swift
//  registration
//
//  Created by Mac on 10/9/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        SqliteManager.shared().setupConnection()
        IQKeyboardManager.shared.enable = true
        handleRootVC()
        SqliteManager.shared().setupMediaConnection()
        return true
    }
    
    func openOnLogInScreen() {
        let sb = UIStoryboard(name: StoryBroard.main, bundle: nil)
        let logInVC = sb.instantiateViewController(withIdentifier: StoryBroard.LogInVC) as! LogInVC
        let navController = UINavigationController(rootViewController: logInVC)
        self.window?.rootViewController = navController
    }
}

extension AppDelegate {
    private func handleRootVC() {
        let def = UserDefaults.standard
        if let isLoggedIn = def.object(forKey: StoryBroard.isLoggedIn) as? Bool {
            if isLoggedIn {
                self.openOnMainScreen()
            } else {
                self.openOnLogInScreen()
            }
        }
    }
    
    func openOnProfileScreen() {
        let sb = UIStoryboard(name: StoryBroard.main, bundle: nil)
        let profileVC = sb.instantiateViewController(withIdentifier: StoryBroard.ProfileVC) as! ProfileVC
        let navController = UINavigationController(rootViewController: profileVC)
        self.window?.rootViewController = navController
    }
    
    func openOnMainScreen() {
        let sb = UIStoryboard(name: StoryBroard.main, bundle: nil)
        let moviesVC = sb.instantiateViewController(withIdentifier: StoryBroard.MoviesVC) as! MoviesVC
        let navController = UINavigationController(rootViewController: moviesVC)
        self.window?.rootViewController = navController
    }
}
