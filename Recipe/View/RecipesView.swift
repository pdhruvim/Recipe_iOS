//
//  RecipesView.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 5/5/25.
//

import SwiftUI

struct RecipesView: View {
    
    @AppStorage("turn_on_dark_mode") var turnOnDarkMode: Bool = false
    @EnvironmentObject var rvm: RecipeViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if let error = rvm.statusMessage {
                    Text(error)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                LazyVGrid(columns: columns) {
                    ForEach(rvm.isSearching ? rvm.filteredRecipes : rvm.recipes) { recipe in
                        RecipeView(recipe: recipe)
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .navigationTitle("Recipes")
            .onChange(of: rvm.searchString) { _ in
                rvm.runFilteringTask()
            }
            .padding(.top)
            .preferredColorScheme(turnOnDarkMode ? .dark : .light)
            .refreshable {
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                await rvm.loadRecipes()
            }
            .scrollIndicators(.hidden)
            .searchable(text: $rvm.searchString, placement: .automatic, prompt: Text("Search by recipe name or cuisine"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button("Default - Name (A to Z)") {
                            rvm.recipes.sort { $0.name < $1.name }
                        }
                        Button("Name (Z to A)") {
                            rvm.recipes.sort { $0.name > $1.name }
                        }
                        Button("Cuisine (A to Z)") {
                            rvm.recipes.sort { $0.cuisine < $1.cuisine }
                        }
                        Button("Cuisine (Z to A)") {
                            rvm.recipes.sort { $0.cuisine > $1.cuisine }
                        }
                    } label: {
                        HStack(spacing: 5) {
                            Image(systemName: "arrow.up.arrow.down")
                                .font(.caption2)
                            Text("Sort")
                        }
                    }

                }
            }
        }
    }
}

#Preview {
    RecipesView()
        .environmentObject(RecipeViewModel(recipeService: RecipeService()))
}
