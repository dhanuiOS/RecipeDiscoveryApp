//
//  RecipeDetail.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import Foundation

struct RecipeDetail: Codable, Identifiable {
    let id: Int?
    let name: String
    let image: String?
    let description: String?
    let cookTimeMinutes: Int?
    let prepTimeMinutes: Int?
    let difficulty: String?
    let servings: Int?
    let caloriesPerServing: Int?
    let cuisine: String?
    let ingredients: [String]?
    let instructions: [String]?
    let rating: Double?
    let reviewCount: Int?
    let tags: [String]?
}
