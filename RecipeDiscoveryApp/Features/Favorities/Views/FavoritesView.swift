//
//  FavoritesView.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import SwiftUI
import Combine

struct FavoritesView: View {
    @EnvironmentObject var recipeListVM: RecipeListViewModel
    var body: some View {
        NavigationStack {
            VStack {
                if $recipeListVM.favorites.isEmpty {
                    // Empty State
                    VStack(spacing: 12) {
                        Image(systemName: "heart.slash")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                        Text("No Favorites yet")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    // Favorites List
                    List {
                        ForEach(recipeListVM.favorites) { recipe in
                            label: do {
                                RecipeRowView(recipe: recipe)
                                    .environmentObject(recipeListVM)
                            }
                        }
                        // Footer Section
                        VStack(spacing: 10) {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.green)
                            Text("Your Favorite Recipes")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("Save recipes you love for easy access and quick meal planning.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 20)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("My Favorites")
        }
    }
}


