//
//  FilterButtons.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import SwiftUI

struct FilterButtons: View {
    @Binding var selected: String
    private let filters = ["All", "Vegetarian", "Vegan", "Gluten-Free", "Keto"]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(filters, id: \.self) { filter in
                    Button {
                        selected = filter
                    } label: {
                        Text(filter)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(selected == filter ? Color.blue : Color.gray.opacity(0.2))
                            .foregroundColor(selected == filter ? .white : .primary)
                            .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
