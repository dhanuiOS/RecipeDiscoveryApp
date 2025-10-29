//
//  MockRecipeRepository.swift
//  RecipeDiscoveryAppTests
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import XCTest

@testable import RecipeDiscoveryApp

final class MockRecipeRepository: RecipeRepositoryProtocol {
    var mockRecipes: [Recipe] = []
    var savedFavorites: [Recipe] = []
    var removedFavorites: [Recipe] = []

    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        completion(.success(mockRecipes))
    }

    func saveFavorite(_ recipe: Recipe) {
        savedFavorites.append(recipe)
    }

    func removeFavorite(_ recipe: Recipe) {
        savedFavorites.removeAll(where: { $0.id == recipe.id }) // remove from favorites
        removedFavorites.append(recipe)
    }

    func fetchFavorites() -> [Recipe] {
        return savedFavorites
    }
}

