//
//  Factories.swift
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

extension UIColor {
    static let lightGreen = UIColor(red: 0/255, green: 171/255, blue: 90/255, alpha: 1)
}
