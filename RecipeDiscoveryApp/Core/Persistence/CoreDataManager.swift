//
//  CoreDataManager.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import SwiftUI
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let context = CoreDataStack.shared.context

    func saveFavorite(_ recipe: Recipe) {
        let entity = RecipeEntity(context: context)
        entity.update(from: recipe)
        CoreDataStack.shared.saveContext()
    }

    func removeFavorite(_ recipe: Recipe) {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", recipe.id)
        if let results = try? context.fetch(request), let obj = results.first {
            context.delete(obj)
            CoreDataStack.shared.saveContext()
        }
    }

    func fetchFavorites() -> [Recipe] {
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        if let entities = try? context.fetch(request) {
            return entities.map { $0.toRecipe() }
        }
        return []
    }
}
