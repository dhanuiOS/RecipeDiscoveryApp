//
//  Untitled.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//


import SwiftUI
import CoreData
import Combine

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Recipe] = []

    private let viewContext = CoreDataStack.shared.container.viewContext

    func addFavorite(_ recipe: Recipe) {
        let entity = RecipeEntity(context: viewContext)
        entity.update(from: recipe)

        do {
            try viewContext.save()
            loadFavorites()
        } catch {
            print("Error saving favorite: \(error)")
        }
    }

    func loadFavorites() {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == %@", NSNumber(value: true))

        do {
            let result = try viewContext.fetch(request)
            favorites = result.map { $0.toRecipe() }
        } catch {
            print("Error fetching favorites: \(error)")
        }
    }

    func removeFavorite(_ recipe: Recipe) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", recipe.id)

        do {
            let entities = try viewContext.fetch(request)
            entities.forEach { viewContext.delete($0) }
            try viewContext.save()
            loadFavorites()
        } catch {
            print("Error removing favorite: \(error)")
        }
    }
}
