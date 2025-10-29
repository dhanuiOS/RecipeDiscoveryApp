//
//  RecipeRepositoryProtocol.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import Foundation

protocol RecipeRepositoryProtocol {
    func saveFavorite(_ recipe: Recipe)
    func removeFavorite(_ recipe: Recipe)
    func fetchFavorites() -> [Recipe]
}
