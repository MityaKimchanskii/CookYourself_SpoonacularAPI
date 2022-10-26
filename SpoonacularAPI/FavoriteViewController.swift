//
//  FavoriteViewController.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/26/22.
//

import UIKit

class FavoriteViewController: SpoonacularViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        title = "Favorite"
        
        setup()
        layout()
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "heart.circle", title: "Favorite")
    }
}

// MARK: - Helper Methods
extension FavoriteViewController {
    private func setup() {
        
    }
    
    private func layout() {
        
    }
}
