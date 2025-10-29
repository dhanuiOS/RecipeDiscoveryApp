//
//  Recipe.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//


import Foundation

struct RecipeResponse: Codable {
    let recipes: [Recipe]
    let total: Int
    let skip: Int
    let limit: Int
    
}

struct Recipe: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let ingredients: [String]?
    let instructions: [String]?
    let prepTimeMinutes: Int?
    let cookTimeMinutes: Int?
    let difficulty: String?
    let cuisine: String?
    let caloriesPerServing: Int?
    let rating: Double?
    let servings: Int?
    let reviewCount: Int?
    let image: String?
    let tags: [String]?

    var imageURL: URL? {
        URL(string: image ?? "")
    }
}
