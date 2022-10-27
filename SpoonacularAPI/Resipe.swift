//
//  ResipeModel.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/25/22.
//

import Foundation

struct JSONObject: Decodable {
    let results: [Recipe]
}

struct Recipe: Decodable {
    let id: Int
    let title: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case imageURL = "image"
    }
}

struct Details: Decodable, Equatable {
    let id: Int
    let title: String
    let timeForPreparing: Int?
    let imageURL: String?
    let recipeDescription: String?
    let instruction: String?
    let servings: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case timeForPreparing = "readyInMinutes"
        case imageURL = "image"
        case recipeDescription = "summary"
        case instruction = "instructions"
        case servings = "servings"
    }
}

struct Joke: Decodable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
    }
}
