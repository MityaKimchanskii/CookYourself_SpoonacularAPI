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
//    let nutrition: Nutrition
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case imageURL = "image"
//        case nutrition = "nutrition"
    }
}

//struct Nutrition: Decodable {
//    let nutrients: [Fat]
//
//    enum CodingKeys: String, CodingKey {
//        case nutrients = "nutrients"
//    }
//}
//
//struct Fat: Decodable {
//    let name: String
//    let amount: Float
//    let unit: String
//
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case amount = "amount"
//        case unit = "unit"
//    }
//}
