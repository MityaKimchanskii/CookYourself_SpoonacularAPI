//
//  DetailViewController.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/26/22.
//

import UIKit

class DetailsViewController: UIViewController {

    // MARK: - Properties
    var recipe: Recipe?
    
    private let closeButton = UIButton()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGreen
    }
}


extension DetailsViewController {
    // MARK: - Actions
    @objc private func closeButtonTapped(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    private func activateCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped(sender:)), for: .touchUpInside)
    }
}
