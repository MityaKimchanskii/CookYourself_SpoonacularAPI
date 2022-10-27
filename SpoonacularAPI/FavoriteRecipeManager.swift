//
//  RecipeDetailsManager.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/26/22.
//

import UIKit
import RealmSwift

class FavoriteRecipeManager {
    
    static let shared = FavoriteRecipeManager()
    private init() {}
    
    let realm = try! Realm()
    var recipeDetailsArray: Results<FavoriteRecipe>?
    
    // CRUD
    // Create
    func saveFavoriteRecipe(favoriteRecipe: FavoriteRecipe) {
        do {
            try realm.write({
                realm.add(favoriteRecipe)
            })
        } catch {
            print("Error saving details \(error)")
        }
    }
    
    // Read
    func fetchAllFavoriteRecipes() -> Results<FavoriteRecipe>? {
        recipeDetailsArray = realm.objects(FavoriteRecipe.self)
        return recipeDetailsArray
    }
    
    // Delete
    func deleteFavoriteRecipe(favoriteRecipeForDelete: FavoriteRecipe) {
        do {
            try realm.write({
                realm.delete(favoriteRecipeForDelete)
            })
        } catch {
            print("Error saving details \(error)")
        }
    }
    
    func fetchImageForFavoriteRecipe(favoriteRecipe: FavoriteRecipe, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let baseURLForImage = URL(string: favoriteRecipe.imageURL) else { return completion(.failure(.invalidURL)) }
       
        URLSession.shared.dataTask(with: baseURLForImage) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("Image status code: \(response.statusCode)")
                }
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            return completion(.success(image))
        }.resume()
    }
}

