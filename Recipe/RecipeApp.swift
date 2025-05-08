//
//  RecipeApp.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 4/30/25.
//

import SwiftUI

@main
struct RecipeApp: App {
    
    @StateObject private var rvm = RecipeViewModel(recipeService: RecipeService())
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(rvm)
                .task {
                    await rvm.loadRecipes()
                }
        }
    }
}
