//
//  FavoriteDetailsViewController.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/27/22.
//

import Foundation
import UIKit

class FavoriteDetailsViewController: UIViewController {
    
    // MARK: - Properties
    var favoriteRecipe: FavoriteRecipe?
    
    // MARK: - Views
    private let closeButton = UIButton()
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let recipeDescriptionLabel = UILabel()
    private let instructionLabel = UILabel()
    private let servingsLabel = UILabel()
    private let instructionTitleLabel = UILabel()
    private let recipeDescriptionTitleLabel = UILabel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        layout()
        fetchImage()
        favoriteDetails()
        activateCloseButton()
    }
}

// MARK: - Extension Actions
extension FavoriteDetailsViewController {
    @objc private func closeButtonTapped(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    private func activateCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Extensions Helper Methods
extension FavoriteDetailsViewController {
    private func setup() {
        // closeButton
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeButton.tintColor = .red
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        // titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .lightGreen
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // imageView
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // scrollView
        scrollView.delegate = self
        scrollView.scrollsToTop = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // stackView
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // servingsLabel
        servingsLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        servingsLabel.numberOfLines = 0
        servingsLabel.textAlignment = .left
        servingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // recipeDescriptionTitleLabel
        recipeDescriptionTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        recipeDescriptionTitleLabel.textAlignment = .justified
        recipeDescriptionTitleLabel.text = "Description:"
        recipeDescriptionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // recipeDescriptionLabel
        recipeDescriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        recipeDescriptionLabel.numberOfLines = 0
        recipeDescriptionLabel.lineBreakMode = .byWordWrapping
        recipeDescriptionLabel.textAlignment = .justified
        recipeDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // instructionTitleLabel
        instructionTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        instructionTitleLabel.textAlignment = .justified
        instructionTitleLabel.text = "Instruction:"
        instructionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // instructionLabel
        instructionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        instructionLabel.numberOfLines = 0
        instructionLabel.lineBreakMode = .byWordWrapping
        instructionLabel.textAlignment = .justified
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(closeButton)
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(servingsLabel)
        stackView.addArrangedSubview(recipeDescriptionTitleLabel)
        stackView.addArrangedSubview(recipeDescriptionLabel)
        stackView.addArrangedSubview(instructionTitleLabel)
        stackView.addArrangedSubview(instructionLabel)
        
        NSLayoutConstraint.activate([
            // closeButton
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            
            // titleLabel
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: closeButton.bottomAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 1),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // imageView
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            imageView.widthAnchor.constraint(equalToConstant: 300),
        
            // scrollView
            scrollView.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 1),
            scrollView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: scrollView.trailingAnchor, multiplier: 2),
            scrollView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0),
            
            // stackView
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.bounds.width - 32)
        ])
    }
    
    private func fetchImage() {
        guard let favoriteRecipe = favoriteRecipe else { return }
        FavoriteRecipeManager.shared.fetchImageForFavoriteRecipe(favoriteRecipe: favoriteRecipe) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            case .failure(let error):
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
    private func favoriteDetails() {
        guard let favoriteRecipe = favoriteRecipe else { return }
        titleLabel.text = favoriteRecipe.title
        servingsLabel.text = "Dish for \(favoriteRecipe.numberOfPersons) persons"
        
        let description = favoriteRecipe.descriptionData.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        recipeDescriptionLabel.text = description
        
        let instruction = favoriteRecipe.instructionData.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        instructionLabel.text = instruction
    }
}

// MARK: - Extension UIScrollView
extension FavoriteDetailsViewController: UIScrollViewDelegate {}
