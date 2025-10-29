//
//  Untitled.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

final class RecipeRepository: RecipeRepositoryProtocol {
    private let coreDataManager = CoreDataManager.shared

    func saveFavorite(_ recipe: Recipe) {
        coreDataManager.saveFavorite(recipe)
    }

    func removeFavorite(_ recipe: Recipe) {
        coreDataManager.removeFavorite(recipe)
    }

    func fetchFavorites() -> [Recipe] {
        coreDataManager.fetchFavorites()
    }
}
