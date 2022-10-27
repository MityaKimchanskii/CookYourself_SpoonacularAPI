//
//  SpoonacularAPITests.swift
//  SpoonacularAPITests
//
//  Created by Mitya Kim on 10/25/22.
//

import XCTest
@testable import SpoonacularAPI

class SpoonacularAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
         [
           {
             "id": 78023,
             "title": "Pasta With Tuna",
             "timeForPreparing": 3,
             "imageURL" : "https://spoonacular.com/recipeImages/654959-556x370.jpg",
             "recipeDescription": "Pasta With Tuna might be just the main course you are searching for.",
             "instruction": "Cook pasta in a large pot of boiling water until al dente.",
             "servings": 3,
           }
          ]
        """
        
        // Game on here 🕹
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let result = try decoder.decode([Details].self, from: data)
        
        XCTAssertEqual(result.count, 2)
        
        let recipe = result[0]
        XCTAssertEqual(recipe.id, 78023)
        XCTAssertEqual(recipe.title, "Pasta With Tuna")
        XCTAssertEqual(recipe.timeForPreparing, 3)
        XCTAssertEqual(recipe.imageURL, "https://spoonacular.com/recipeImages/654959-556x370.jpg")
        XCTAssertEqual(recipe.recipeDescription, "Pasta With Tuna might be just the main course you are searching for.")
        XCTAssertEqual(recipe.instruction, "Cook pasta in a large pot of boiling water until al dente.")
        XCTAssertEqual(recipe.servings, 3)
    }
}

