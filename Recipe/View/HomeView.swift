//
//  HomeView.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 4/30/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "cup.and.saucer.fill")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
