//
//  FavoriteViewController.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/26/22.
//

import UIKit
import RealmSwift

class FavoriteViewController: SpoonacularViewController {
    
    // MARK: - Views
    private let tableView = UITableView()
    private var results: Results<FavoriteRecipe>?
    private var imageView = UIImageView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        title = "Favorite"
        
        style()
        layout()
        fetchAllFavorite() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllFavorite()
        self.tableView.reloadData()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageView.layer.add(boundsKeyFrameAnimation(), forKey: "bounce")
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "heart.circle", title: "Favorite")
    }
}

// MARK: - Helper Methods
extension FavoriteViewController {
    private func style() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FaforiteCell.self, forCellReuseIdentifier: FaforiteCell.reuseID)
        tableView.separatorColor = .lightGreen
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "person3")
    }
    
    private func layout() {
        view.addSubview(tableView)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 20),
            imageView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 20),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            
            // tableView
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 1),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchAllFavorite() {
        results = FavoriteRecipeManager.shared.fetchAllFavoriteRecipes()
    }
}

// MARK: - Extension UITableViewDelegata, UITableViewDataSource
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FaforiteCell.rowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let results = results else { return 0 }
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FaforiteCell.reuseID, for: indexPath) as? FaforiteCell else { return UITableViewCell() }
        guard let results = results else { return UITableViewCell() }
        cell.favoriteRecipe = results[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let results = results else { return }
        if editingStyle == .delete {
            let recipeForDelete = results[indexPath.row]
            FavoriteRecipeManager.shared.deleteFavoriteRecipe(favoriteRecipeForDelete: recipeForDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let results = results else { return }
        let result = results[indexPath.row]
        let detailVC = FavoriteDetailsViewController()
        detailVC.favoriteRecipe = result
        self.present(detailVC, animated: true)
    }
}


