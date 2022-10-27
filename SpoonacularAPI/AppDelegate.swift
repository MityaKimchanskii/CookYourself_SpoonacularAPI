//
//  AppDelegate.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/25/22.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let homeVC = HomeViewController()
    let searchVC = SearchRecipeViewController()
    let favoriteVC = FavoriteViewController()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white

        let welcomeVC = WelcomeContainerViewController()
        welcomeVC.delegate = self
        
        window?.rootViewController = welcomeVC
        
        return true
    }
}

extension AppDelegate: WelcomeContainerViewControllerDelegate {
    func didFinishWelcome() {
        setRootViewController()
    }
}

extension AppDelegate {
    func setRootViewController() {
        let homeNC = UINavigationController(rootViewController: homeVC)
        let favoriteNC = UINavigationController(rootViewController: favoriteVC)
        let searchNC = UINavigationController(rootViewController: searchVC)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNC, searchNC, favoriteNC]

        tabBarController.tabBar.tintColor = .lightGreen
        tabBarController.tabBar.isTranslucent = false
        
        guard let window = self.window else { return }

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
