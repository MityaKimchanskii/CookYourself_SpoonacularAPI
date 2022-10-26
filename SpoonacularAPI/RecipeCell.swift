//
//  RecipeCell.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/25/22.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    // MARK: - Properties
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    static let reuseID = "recipeCell"
    static let rowHeight: CGFloat = 116
    private let widthAndHeightImage: CGFloat = 100
    
    // MARK: - Views
    let titleLabel = UILabel()
    let recipeImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions Helper Methods
extension RecipeCell {
    private func setup() {
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 12
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontForContentSizeCategory = true
    }
    
    private func layout() {
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            
            recipeImageView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            recipeImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: recipeImageView.bottomAnchor, multiplier: 1),
            recipeImageView.widthAnchor.constraint(equalToConstant: widthAndHeightImage),
            recipeImageView.heightAnchor.constraint(equalToConstant: widthAndHeightImage),
            
            trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: recipeImageView.trailingAnchor, multiplier: 1),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func updateViews() {
        guard let recipe = recipe else { return }
        fetchAndSetImage(recipe: recipe)
        titleLabel.text = recipe.title
    }
    
    private func fetchAndSetImage(recipe: Recipe) {
        RecipeManager.shared.fetchImage(recipe: recipe) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.recipeImageView.image = image
                }
            case .failure(let error):
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
}
