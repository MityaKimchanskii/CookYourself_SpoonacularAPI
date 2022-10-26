//
//  ViewController.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/25/22.
//

import UIKit

class HomeViewController: SpoonacularViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
//        view.backgroundColor = .systemCyan
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "house.circle", title: "Home")
    }
    
    private func style() {
        
    }

    private func layout() {
        
    }
}

