//
//  DetailViewController.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/26/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var favoriteResipes: [Details] = []

    // MARK: - Properties
    var recipe: Recipe?
    var id: Int?
    var details: Details?
    private var spriteImages = [UIImage]()
    
    // MARK: - Views
    private let closeButton = UIButton()
    private let favoriteButton = UIButton()
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let recipeDescriptionLabel = UILabel()
    private let instructionLabel = UILabel()
    private let servingsLabel = UILabel()
    private let instructionTitleLabel = UILabel()
    private let recipeDescriptionTitleLabel = UILabel()
    private let heartImage = UIImageView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setup()
        layout()
        fetchImage()
        fetchDetails()
        activateCloseButton()
        activateFavoriteButton()
    }
}

// MARK: - Extension Actions
extension DetailsViewController {
    @objc private func closeButtonTapped(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    private func activateCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func favoriteButtonTapped(sender: UIButton) {
        twitterAnimation()
        guard let details = details else { return }
        
        if !favoriteResipes.contains(details) {
            favoriteResipes.append(details)
            print(favoriteResipes)
        }
    }
    
    private func activateFavoriteButton() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Extensions Helper Methods
extension DetailsViewController {
    private func setup() {
        // closeButton
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeButton.tintColor = .red
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        // favoriteButton
        favoriteButton.setImage(UIImage(systemName: "heart.circle"), for: .normal)
        favoriteButton.tintColor = .lightGreen
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        // heartImage
        heartImage.image = UIImage(named: "tile00")
        heartImage.translatesAutoresizingMaskIntoConstraints = false
        heartImage.alpha = 0.5
    }
    
    private func layout() {
        view.addSubview(closeButton)
        view.addSubview(favoriteButton)
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(heartImage)
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
            
            // favoriteButton
            favoriteButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: favoriteButton.trailingAnchor, multiplier: 1),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            
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
            stackView.widthAnchor.constraint(equalToConstant: view.bounds.width - 32),
            
            // heartImage
            heartImage.heightAnchor.constraint(equalToConstant: 200),
            heartImage.widthAnchor.constraint(equalToConstant: 200),
            heartImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heartImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func fetchImage() {
        guard let recipe = recipe else { return }
        RecipeManager.shared.fetchImage(recipe: recipe) { [weak self] result in
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
    
    private func fetchDetails() {
        guard let id = id else { return }
        RecipeManager.shared.fetchRecipeDetails(with: id) { [weak self] result in
            switch result {
            case .success(let details):
                DispatchQueue.main.async {
                    self?.details = details
                    self?.titleLabel.text = details.title
                    
                    guard let persons = details.servings else { return }
                    self?.servingsLabel.text = "Dish for \(persons) persons"
                    
                    guard let str2 = details.recipeDescription else { return }
                    let description = str2.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                    self?.recipeDescriptionLabel.text = description
                    
                    guard let str1 = details.instruction else { return }
                    let instruction = str1.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                    self?.instructionLabel.text = instruction
                }
            case .failure(let error):
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
}

// MARK: - Extension UIScrollView
extension DetailsViewController: UIScrollViewDelegate {}

// MARK: - Animation
extension DetailsViewController {
    private func twitterAnimation() {
        heartImage.animationImages = spriteImages
        heartImage.animationDuration = 3
        heartImage.animationRepeatCount = 1
        heartImage.startAnimating()
        
        for i in 0..<29 {
            spriteImages.append(UIImage(named: "tile0\(i)")!)
        }
    }
}
