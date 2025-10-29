//
//  RecipeDiscoveryAppApp.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import SwiftUI
import CoreData

@main
struct RecipeDiscoveryAppApp: App {
    @StateObject private var recipeListViewModel = RecipeListViewModel()


    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(recipeListViewModel)
        }
    }
}
