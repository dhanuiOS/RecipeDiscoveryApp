//
//  RecipeService.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import SwiftUI
import Foundation

final class RecipeService {
    private let baseURL = URL(string: "https://dummyjson.com/recipes")!
    func fetchRecipes() async throws -> [Recipe] {
        let (data, _) = try await URLSession.shared.data(from: baseURL)
        let response = try JSONDecoder().decode(RecipeResponse.self, from: data)
        return response.recipes
    }

    func searchRecipes(query: String) async throws -> [Recipe] {
        guard let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://dummyjson.com/recipes/search?q=\(encoded)") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(RecipeResponse.self, from: data)
        return response.recipes
    }
    
    func fetchRecipeDetail(by id: Int) async throws -> RecipeDetail {
          // Sample API: Replace with actual endpoint or logic
          let urlString = "https://dummyjson.com/recipes/\(id)"
          guard let url = URL(string: urlString) else {
              throw URLError(.badURL)
          }

          let (data, _) = try await URLSession.shared.data(from: url)
          return try JSONDecoder().decode(RecipeDetail.self, from: data)
      }
}

