//
//  Untitled.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import SwiftUI
import Combine
import Foundation

final class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var favorites: [Recipe] = []
    @Published var searchText: String = ""
    @Published var filter: String = "All"
    @Published var isLoading = false

    private let service: RecipeService
    private let repository: RecipeRepositoryProtocol

    // MARK: - Init
    init(service: RecipeService = RecipeService(),
         repository: RecipeRepositoryProtocol = RecipeRepository()) {
        self.service = service
        self.repository = repository
    }

    // MARK: - Favorites Logic
    func toggleFavorite(_ recipe: Recipe) {
        if let index = favorites.firstIndex(where: { $0.id == recipe.id }) {
            favorites.remove(at: index)
            repository.removeFavorite(recipe)
        } else {
            favorites.append(recipe)
            repository.saveFavorite(recipe)
        }
        loadFavorites()
    }

    func isFavorite(_ recipe: Recipe) -> Bool {
        favorites.contains(where: { $0.id == recipe.id })
    }

    func loadFavorites() {
        favorites = repository.fetchFavorites()
    }

    // MARK: - Fetch Recipes
    @MainActor
    func fetchRecipes() async {
        isLoading = true
        defer { isLoading = false }

        do {
            recipes = try await service.fetchRecipes()
        } catch {
            print("❌ Error fetching recipes:", error)
            recipes = []
        }
    }

    // MARK: - Filter & Search
    var filteredRecipes: [Recipe] {
        var filtered = recipes

        // 🔍 Search by name or ingredients
        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                ($0.ingredients?.joined(separator: " ").localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }

        // Filter by dietary restriction
        if filter != "All" {
            filtered = filtered.filter { recipe in
                recipe.tags?.contains(where: { $0.localizedCaseInsensitiveContains(filter) }) ?? false
            }
        }

        return filtered
    }
}
