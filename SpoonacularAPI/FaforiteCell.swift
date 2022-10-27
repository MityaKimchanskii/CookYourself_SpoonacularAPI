//
//  File.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/26/22.
//

import UIKit

class FaforiteCell: UITableViewCell {
    
    // MARK: - Properties
    var favoriteRecipe: FavoriteRecipe? {
        didSet {
            updateViews()
        }
    }
    
    static let reuseID = "favoriteCell"
    static let rowHeight: CGFloat = 116
    private let widthAndHeightImage: CGFloat = 100
    
    // MARK: - Views
    let nameLabel = UILabel()
    let favoriteImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        layoutCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions Helper Methods
extension FaforiteCell {
    private func setupCell() {
        self.selectionStyle = .none
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.contentMode = .scaleAspectFill
        favoriteImageView.clipsToBounds = true
        favoriteImageView.layer.cornerRadius = 12
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontForContentSizeCategory = true
    }
    
    private func layoutCell() {
        contentView.addSubview(favoriteImageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            favoriteImageView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            favoriteImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: favoriteImageView.bottomAnchor, multiplier: 1),
            favoriteImageView.widthAnchor.constraint(equalToConstant: widthAndHeightImage),
            favoriteImageView.heightAnchor.constraint(equalToConstant: widthAndHeightImage),
            
            trailingAnchor.constraint(equalToSystemSpacingAfter: nameLabel.trailingAnchor, multiplier: 1),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: favoriteImageView.trailingAnchor, multiplier: 1),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func updateViews() {
        guard let favoriteRecipe = favoriteRecipe else { return }
        self.nameLabel.text = favoriteRecipe.title
        fetchAndSetImage(favoriteRecipe: favoriteRecipe)
    }
    
    private func fetchAndSetImage(favoriteRecipe: FavoriteRecipe) {
        FavoriteRecipeManager.shared.fetchImageForFavoriteRecipe(favoriteRecipe: favoriteRecipe) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.favoriteImageView.image = image
                }
            case .failure(let error):
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
}


