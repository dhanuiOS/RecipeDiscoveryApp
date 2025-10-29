//
//  RecipeRowView.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    @EnvironmentObject var viewModel: RecipeListViewModel

    var body: some View {
        HStack(spacing: 12) {
            AsyncImageView(url: recipe.imageURL)
                .frame(width: 72, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 6) {
                // Recipe Name
                Text(recipe.name)
                    .font(.headline)
                // Cook Time & Servings Row
                HStack(spacing: 10) {
                    if let cookTime = recipe.cookTimeMinutes {
                        HStack(spacing: 3) {
                            Image(systemName: "clock")
                                .font(.system(size: 11))
                            Text("\(cookTime) min")
                                .font(.caption)
                        }
                        .foregroundColor(.secondary)
                    }

                    if let servings = recipe.servings {
                        HStack(spacing: 3) {
                            Image(systemName: "person.2.fill")
                                .font(.system(size: 11))
                            Text("\(servings) Servings")
                                .font(.caption)
                        }
                        .foregroundColor(.secondary)
                    }
                }

                // Rating & Difficulty Row
                if let rating = recipe.rating {
                    Text("⭐️ \(String(format: "%.1f", rating)) • \(recipe.difficulty ?? "N/A")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                // ✅ Tags Section
                               if let tags = recipe.tags, !tags.isEmpty {
                                   ScrollView(.horizontal, showsIndicators: false) {
                                       HStack(spacing: 6) {
                                           ForEach(tags, id: \.self) { tag in
                                               Text(tag)
                                                   .font(.caption2)
                                                   .padding(.horizontal, 8)
                                                   .padding(.vertical, 4)
                                                   .background(Color.gray.opacity(0.15))
                                                   .cornerRadius(8)
                                           }
                                       }
                                   }
                                   .padding(.top, 2)
                 }
            }
            
            Spacer()
            Button {
                  viewModel.toggleFavorite(recipe)
              } label: {
                  Image(systemName: viewModel.isFavorite(recipe) ? "star.fill" : "star")
                      .foregroundColor(.orange)
              }
              .buttonStyle(.plain)
          }
        .padding(.vertical, 8)
    }
}



