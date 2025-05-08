//
//  RecipeView.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 4/30/25.
//

import SwiftUI

struct RecipeView: View {
    
    @EnvironmentObject var rvm: RecipeViewModel
    var imageService = ImageService(imageCache: ImageDiskCache.shared, netManager: NetworkManager.shared)
    @State private var image: Image? = nil
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomTrailing) {
                image?
                    .resizable()
                    .frame(width: 160, height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                
                Button {
                    rvm.toggleFavorite(recipeUUID: recipe.uuid)
                } label: {
                    ZStack {
                        Circle()
                            .foregroundStyle(Color("Primary Inverse"))
                        Image(systemName: rvm.isFavorite(recipeUUID: recipe.uuid) ? "heart.fill" : "heart")
                            .foregroundStyle(.red)
                    }
                    .frame(width: 30, height: 30)
                    .padding(8)
                }
            }
            
            Text(recipe.name)
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
            Text(recipe.cuisine)
                .font(.callout)
        }
        .frame(width: 160, height: 270, alignment: .top)
        .task {
            image = await imageService.getImage(recipeName: recipe.name, photoURL: recipe.photo_url_small)
        }
    }
}

#Preview {
    RecipeView(recipe: Recipe(cuisine: "Indian", name: "Kaju Curry", photo_url_small: "https://www.cookwithmanali.com/wp-content/uploads/2021/07/Kaju-Masala-Kaju-Curry.jpg", uuid: UUID().uuidString))
        .environmentObject(RecipeViewModel(recipeService: RecipeService()))
}
