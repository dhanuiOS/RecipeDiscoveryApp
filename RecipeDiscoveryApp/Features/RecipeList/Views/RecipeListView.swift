//
//  RecipeListView.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import SwiftUI
import Foundation

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading recipes...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else if viewModel.recipes.isEmpty {
                    VStack(spacing: 10) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.orange)
                        Text("No data found")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else {
                    VStack(spacing: 10) {
                        // Show Search bar
                        SearchBarView(searchText: $viewModel.searchText)
                        // Show Filter buttons
                        FilterButtons(selected: $viewModel.filter)
                        // List or “No match” message
                        if viewModel.filteredRecipes.isEmpty {
                            VStack(spacing: 10) {
                                Image(systemName: "magnifyingglass.circle")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray)
                                Text("No matching recipes found")
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        } else {
                            List(viewModel.filteredRecipes) { recipe in
                                NavigationLink(value: recipe) {
                                    RecipeRowView(recipe: recipe)
                                }
                            }
                            .listStyle(.plain)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle("Recipes")
            .task {
                await viewModel.fetchRecipes()
            }
            // Navigation destination
              .navigationDestination(for: Recipe.self) { recipe in
                  RecipeDetailView(recipe: recipe)
              }
        }
    }
}

