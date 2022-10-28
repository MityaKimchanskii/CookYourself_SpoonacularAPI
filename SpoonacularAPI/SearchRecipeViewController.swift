//
//  SearchRecipeViewController.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/25/22.
//

import UIKit

class SearchRecipeViewController: SpoonacularViewController {
    
    // MARK: - Properties
    private var recipes: [Recipe] = []
    
    // MARK: - Views
    private var searchBar = UISearchBar()
    private var recipeTableView = UITableView()
    private var imageView = UIImageView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Recipe"
        
        hideKeyboardWhenTappedAround()
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageView.layer.add(boundsKeyFrameAnimation(), forKey: "bounce")
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "magnifyingglass.circle", title: "Search Recipe")
    }
}

// MARK: - Extension  Helper Methods
extension SearchRecipeViewController {
    private func style() {
        // imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "person1")
        
        // searchTextfield
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Find your favorite recipe"
        searchBar.returnKeyType = .search
        searchBar.delegate = self
        
        // recipeTableview
        recipeTableView.translatesAutoresizingMaskIntoConstraints = false
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        recipeTableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.reuseID)
        recipeTableView.separatorColor = .lightGreen
    }

    private func layout() {
        view.addSubview(searchBar)
        view.addSubview(recipeTableView)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            // imageView
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 20),
            imageView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 20),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            
            // searchTextField
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchBar.trailingAnchor, multiplier: 1),
            
            // recipeTableView
            recipeTableView.topAnchor.constraint(equalToSystemSpacingBelow: searchBar.bottomAnchor, multiplier: 1),
            recipeTableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: recipeTableView.trailingAnchor, multiplier: 1),
            recipeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchRecipes(search: String) {
        RecipeManager.shared.fetchRecipes(value: search) { [weak self] result in
            switch result {
            case .success(let recipes):
                DispatchQueue.main.async {
                    self?.recipes = recipes
                    self?.recipeTableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.attentionAlert()
                }
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
}

// MARK: - Extension TableView Delegate & DataSource
extension SearchRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RecipeCell.rowHeight
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.reuseID, for: indexPath) as? RecipeCell else { return UITableViewCell() }
        let recipe = recipes[indexPath.row]
        cell.recipe = recipe
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        let detailVC = DetailsViewController()
        detailVC.recipe = recipe
        detailVC.id = recipe.id
        self.present(detailVC, animated: true)
    }
}

// MARK: - Extension TextField
extension SearchRecipeViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Extension SearcBar
extension SearchRecipeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let recipe = searchBar.text {
                self.fetchRecipes(search: recipe)
                self.searchBar.text = ""
                self.imageView.isHidden = true
        }
    }
}

