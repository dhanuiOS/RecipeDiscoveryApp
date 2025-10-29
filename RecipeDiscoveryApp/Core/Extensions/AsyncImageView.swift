//
//  AsyncImageView.swift
//  RecipeDiscoveryApp
//
//  Created by PINNINTI DHANANJAYARAO on 28/10/25.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    var body: some View {
        if let url = url {
            AsyncImage(url: url) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                ProgressView()
            }
        } else {
            Color.gray.opacity(0.3)
        }
    }
}

