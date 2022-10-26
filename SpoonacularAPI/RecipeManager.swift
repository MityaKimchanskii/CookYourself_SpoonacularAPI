//
//  MealManager.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/25/22.
//

import UIKit

class RecipeManager {
    
    static let shared = RecipeManager()
    private init() {}
    
//https://api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=dc1338c2ac034a59a1bc3f8869e3dc30
    
    let baseURL = URL(string: "https://api.spoonacular.com/")
    let recipesComponent = "recipes"
    let complexSearchComponent = "complexSearch"
    let queryKey = "query"
    let apiKey = "apiKey"
    let apiKeyValue = "dc1338c2ac034a59a1bc3f8869e3dc30"
    
    func fetchRecipes(value: String, completion: @escaping (Result<[Recipe], NetworkError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        let recipesURL = baseURL.appendingPathComponent(recipesComponent)
        let complexSearchURL = recipesURL.appendingPathComponent(complexSearchComponent)
        
        var components = URLComponents(url: complexSearchURL, resolvingAgainstBaseURL: true)
        let query = URLQueryItem(name: queryKey, value: value)
        let apiQuery = URLQueryItem(name: apiKey, value: apiKeyValue)
        components?.queryItems = [query, apiQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        
        // check url in console
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let jsonObject = try JSONDecoder().decode(JSONObject.self, from: data)
                let recipeResults = jsonObject.results
                
                var result: [Recipe] = []
                
                for recipe in recipeResults {
                    result.append(recipe)
                }
                return completion(.success(result))
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    func fetchImage(recipe: Recipe, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        guard let baseURLForImage = URL(string: recipe.imageURL) else { return completion(.failure(.invalidURL)) }
       
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
    
//https://api.spoonacular.com/recipes/{id}/information?apiKey=dc1338c2ac034a59a1bc3f8869e3dc30
    
//https://api.spoonacular.com/recipes/654959/information?apiKey=dc1338c2ac034a59a1bc3f8869e3dc30
    
    //    static func fetchMealDetails(with id: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
    //        guard let baseURLForData = baseURLForData else { return completion(.failure(.invalidURL)) }
    //
    //        var components = URLComponents(url: baseURLForData, resolvingAgainstBaseURL: true)
    //        let dataQuery = URLQueryItem(name: dataKey, value: id)
    //        components?.queryItems = [dataQuery]
    //
    //        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
    //
    //        URLSession.shared.dataTask(with: finalURL) { data, _, error in
    //            if let error = error {
    //                return completion(.failure(.thrownError(error)))
    //            }
    //
    //            guard let data = data else { return completion(.failure(.noData)) }
    //
    //            do {
    //                let mealData = try JSONDecoder().decode(MealData.self, from: data)
    //                let resultOfMealData = mealData.meals[0]
    //                return completion(.success(resultOfMealData))
    //            } catch {
    //                return completion(.failure(.unableToDecode))
    //            }
    //        }.resume()
    //    }
}

