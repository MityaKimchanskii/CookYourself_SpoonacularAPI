//
//  MealManager.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/25/22.
//
//https://api.spoonacular.com/recipes/complexSearch?query=pasta&number=2&apiKey=dc1338c2ac034a59a1bc3f8869e3dc30 - search url
//https://api.spoonacular.com/recipes/{id}/information?apiKey=dc1338c2ac034a59a1bc3f8869e3dc30 - details url
//https://api.spoonacular.com/recipes/654959/information?apiKey=dc1338c2ac034a59a1bc3f8869e3dc30 - details url
//https://api.spoonacular.com/food/jokes/random?apiKey=dc1338c2ac034a59a1bc3f8869e3dc30

import UIKit

class RecipeManager {
    
    static let shared = RecipeManager()
    private init() {}
    let baseURL = URL(string: "https://api.spoonacular.com/")
    let recipesComponent = "recipes"
    let complexSearchComponent = "complexSearch"
    let informationComponent = "information"
    let foodComponent = "food"
    let jokesComponent = "jokes"
    let randomComponent = "random"
    let queryKey = "query"
    let numberKey = "number"
    let numberKeyValue = "20"
    let apiKey = "apiKey"
    let apiKeyValue = "dc1338c2ac034a59a1bc3f8869e3dc30"
    
    func fetchRecipes(value: String, completion: @escaping (Result<[Recipe], NetworkError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        let recipesURL = baseURL.appendingPathComponent(recipesComponent)
        let complexSearchURL = recipesURL.appendingPathComponent(complexSearchComponent)
        
        var components = URLComponents(url: complexSearchURL, resolvingAgainstBaseURL: true)
        
        let query = URLQueryItem(name: queryKey, value: value)
        let numberQuery = URLQueryItem(name: numberKey, value: numberKeyValue)
        let apiQuery = URLQueryItem(name: apiKey, value: apiKeyValue)
        components?.queryItems = [query, numberQuery, apiQuery]
        
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
    
    func fetchRecipeDetails(with id: Int, completion: @escaping (Result<Details, NetworkError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        let recipesURL = baseURL.appendingPathComponent(recipesComponent)
        let idURL = recipesURL.appendingPathComponent("\(id)")
        let informationURL = idURL.appendingPathComponent(informationComponent)
        
        var components = URLComponents(url: informationURL, resolvingAgainstBaseURL: true)
        
        let apiQuery = URLQueryItem(name: apiKey, value: apiKeyValue)
        components?.queryItems = [apiQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            // check url in console
            print(finalURL)
            
            do {
                let recipeDetails = try JSONDecoder().decode(Details.self, from: data)
                let resultDetails = recipeDetails
                return completion(.success(resultDetails))
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    func fetchRundomJoke(completion: @escaping (Result<Joke, NetworkError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let foodURL = baseURL.appendingPathComponent(foodComponent)
        let jokesURL = foodURL.appendingPathComponent(jokesComponent)
        let randomURL = jokesURL.appendingPathComponent(randomComponent)
        
        var components = URLComponents(url: randomURL, resolvingAgainstBaseURL: true)
        let apiQuery = URLQueryItem(name: apiKey, value: apiKeyValue)
        components?.queryItems = [apiQuery]
        
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        
        // check url in console
        print(finalURL)

        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let joke = try JSONDecoder().decode(Joke.self, from: data)
                return completion(.success(joke))
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}

