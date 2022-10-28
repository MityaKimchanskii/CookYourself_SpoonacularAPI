//
//  ViewController.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/25/22.
//

import UIKit

class HomeViewController: SpoonacularViewController {
    
    // MARK: - Views
    private var titleLabel = UILabel()
    private var imageView = UIImageView()
    private var jokeLabel = UILabel()
    private var scrollView = UIScrollView()
    private var stackView = UIStackView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        style()
        layout()
        fetchJoke()
    }
    
    override func commonInit() {
        setTabBarImage(imageName: "house.circle", title: "Home")
    }
}

// MARK: - Helper Methods
extension HomeViewController {
    private func style() {
        // imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "person2")
        
        // titleLabel
        titleLabel.text = "Mood Booster Joke"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        titleLabel.textColor = .lightGreen
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // scrollView
        scrollView.delegate = self
        scrollView.scrollsToTop = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        // stackView
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // jokeLabel
        jokeLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        jokeLabel.numberOfLines = 0
        jokeLabel.textAlignment = .justified
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func layout() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(jokeLabel)
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(jokeLabel)
        
        NSLayoutConstraint.activate([
            // imageView
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            
            // titleLabel
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
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
           
        ])
    }
    
    private func fetchJoke() {
        RecipeManager.shared.fetchRundomJoke { [weak self] result in
            switch result {
            case .success(let joke):
                DispatchQueue.main.async {
                    self?.jokeLabel.text = joke.text
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

// MARK: - Extension UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {}
