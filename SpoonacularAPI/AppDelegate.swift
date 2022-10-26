//
//  AppDelegate.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/25/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white

        
        let homeVC = HomeViewController()
        let searchVC = SearchRecipeViewController()
        let favoriteVC = FavoriteViewController()
        
        let homeNC = UINavigationController(rootViewController: homeVC)
        let favoriteNC = UINavigationController(rootViewController: favoriteVC)
        let searchNC = UINavigationController(rootViewController: searchVC)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNC, searchNC, favoriteNC]
        
        tabBarController.tabBar.tintColor = .lightGreen
        tabBarController.tabBar.isTranslucent = false
        
        window?.rootViewController = tabBarController
//        window?.rootViewController = DetailsViewController()
        
        return true
    }
}



