//
//  FavoritesView.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 5/5/25.
//

import SwiftUI

struct FavoritesView: View {
    
    @AppStorage("turn_on_dark_mode") var turnOnDarkMode: Bool = false
    @EnvironmentObject var rvm: RecipeViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(rvm.favoritedRecipes.sorted(by: <), id: \.self) { uuid in
                        if let recipe = rvm.getFavoriteRecipe(recipeUUID: uuid) {
                            RecipeView(recipe: recipe)
                                .listRowSeparator(.hidden)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            .preferredColorScheme(turnOnDarkMode ? .dark : .light)
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(RecipeViewModel(recipeService: RecipeService()))
}
