//
//  CoreDataStack.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()

    // The NSPersistentContainer that manages Core Data model
    let container: NSPersistentContainer

    private init() {
        
        container = NSPersistentContainer(name: "RecipeModel")

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data store failed: \(error.localizedDescription)")
            } else {
                print(" Core Data loaded successfully: \(description.url?.absoluteString ?? "")")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }

    // MARK: - Save Context
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save Core Data context: \(error)")
            }
        }
    }
}
