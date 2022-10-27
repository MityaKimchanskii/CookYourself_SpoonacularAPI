//
//  Data.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/26/22.
//

import Foundation
import RealmSwift

class FavoriteRecipe: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var imageURL: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var descriptionData: String = ""
    @objc dynamic var instructionData: String = ""
    @objc dynamic var numberOfPersons: Int = 0
}
