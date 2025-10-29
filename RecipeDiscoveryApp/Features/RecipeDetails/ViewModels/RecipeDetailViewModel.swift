//
//  RecipeDetailViewModel.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import SwiftUI
import Combine
@MainActor
final class RecipeDetailViewModel: ObservableObject {
    @Published var recipeDetail: RecipeDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = RecipeService()

    func fetchDetail(id: Int) async {
        isLoading = true
        errorMessage = nil
        do {
            recipeDetail = try await service.fetchRecipeDetail(by: id)
        } catch {
            errorMessage = "Failed to load recipe details"
            print("Error: \(error)")
        }
        isLoading = false
    }
}
