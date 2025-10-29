//
//  RecipeDetailView.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // MARK: - Hero Image
                AsyncImageView(url: recipe.imageURL)
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // MARK: - Title
                Text(recipe.name)
                    .font(.title)
                    .bold()
                
                // MARK: - Quick Info
                HStack(spacing: 12) {
                    if let cookTime = recipe.cookTimeMinutes {
                        Label("\(cookTime) min", systemImage: "clock")
                            .font(.subheadline)
                    }
                    if let servings = recipe.servings {
                        Label("\(servings) servings", systemImage: "person.2")
                            .font(.subheadline)
                    }
                    if let difficulty = recipe.difficulty {
                        Label(difficulty, systemImage: "chart.bar.fill")
                            .font(.subheadline)
                    }
                }
                .foregroundColor(.secondary)
                
                // MARK: - Ingredients
                if let ingredients = recipe.ingredients, !ingredients.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Ingredients")
                            .font(.headline)
                            .padding(.bottom, 4)
                        
                        ForEach(ingredients, id: \.self) { ingredient in
                            HStack(alignment: .top) {
                                Text("•")
                                Text(ingredient)
                            }
                        }
                    }
                }
                
                // MARK: - Instructions (Numbered Points)
                if let steps = recipe.instructions, !steps.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Instructions")
                            .font(.headline)
                            .padding(.bottom, 4)
                        
                        ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                            HStack(alignment: .top, spacing: 8) {
                                Text("\(index + 1).")
                                    .font(.body)
                                    .bold()
                                Text(step)
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                } else {
                    Text("No instructions available.")
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
