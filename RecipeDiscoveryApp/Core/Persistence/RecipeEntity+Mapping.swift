//
//  RecipeEntity+Mapping.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import Foundation
import CoreData

extension RecipeEntity {
    func update(from recipe: Recipe) {
        self.id = Int64(recipe.id)
        self.name = recipe.name
        self.image = recipe.image
        self.cookTimeMinutes = Int64(recipe.cookTimeMinutes ?? 0)
        self.rating = recipe.rating ?? 0
        self.servings = Int64(recipe.servings ?? 0)
        self.difficulty = recipe.difficulty

        //  If 'tags' is Transformable (NSObject)
        if let tags = recipe.tags {
            self.tags = tags as NSObject
        }
        self.isFavorite = true
    }

    func toRecipe() -> Recipe {
        // If Transformable
        let tagsArr = tags as? [String]
        return Recipe(
            id: Int(id),
            name: name ?? "",
            ingredients: nil,
            instructions: nil,
            prepTimeMinutes: nil,
            cookTimeMinutes: Int(cookTimeMinutes),
            difficulty: difficulty,
            cuisine: nil,
            caloriesPerServing: nil,
            rating: rating,
            servings: Int(servings),
            reviewCount: nil,
            image: image,
            tags: tagsArr
        )
    }
}
