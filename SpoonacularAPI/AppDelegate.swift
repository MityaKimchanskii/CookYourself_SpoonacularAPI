//
//  AppDelegate.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/25/22.
//

import UIKit

class SpoonacularViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {}
    
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}



class FavoriteViewController: SpoonacularViewController {
    override func viewDidLoad() {
        title = "Favorite"
//        view.backgroundColor = .systemCyan
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "heart.circle", title: "Favorite")
    }
}

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
        
        return true
    }
}



