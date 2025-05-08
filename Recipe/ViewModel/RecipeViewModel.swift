//
//  RecipeViewModel.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 4/30/25.
//

import Foundation

class RecipeViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    @Published var filteredRecipes: [Recipe] = []
    @Published var favoritedRecipes: [String] = []
    @Published var searchString: String = ""
    @Published var statusMessage: String? = nil

    private let url = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    private let recipeService: RecipeServiceProtocol!
    private var currentTask: Task<Void, Never>?
    
    var isSearching: Bool {
        !searchString.isEmpty
    }
    
    init(recipeService: RecipeServiceProtocol) {
        self.recipeService = recipeService
    }
    
    func loadRecipes() async {
        let result = await recipeService.fetchRecipes(url: url)
        
        await MainActor.run {
            switch result {
            case .success(let parsedRecipes):
                if parsedRecipes.isEmpty { statusMessage = "There are no recipes." }
                recipes = parsedRecipes
            case .failure(let error):
                recipes = []
                switch error {
                case .malformedRecipes:
                    statusMessage = "Invalid response"
                case .invalidURL:
                    statusMessage = "Invalid URL"
                case .networkError(let netError):
                    statusMessage = "\(netError.localizedDescription)"
                }
            }
        }
    }
    
    func runFilteringTask() {
        currentTask?.cancel()
        
        currentTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 500_000_000)
            
            guard !Task.isCancelled else { return }
            
            self?.filterRecipes()
        }
    }
    
    func filterRecipes() {
        filteredRecipes = recipes.filter({ recipe in
            let name = recipe.name.lowercased().contains(searchString.lowercased())
            let cuisine = recipe.cuisine.lowercased().contains(searchString.lowercased())
            return name || cuisine
        })
    }
    
    func toggleFavorite(recipeUUID: String) {
        if favoritedRecipes.contains(recipeUUID) {
            favoritedRecipes.removeAll { $0 == recipeUUID }
        } else {
            favoritedRecipes.append(recipeUUID)
        }
    }
    
    func isFavorite(recipeUUID: String) -> Bool {
        favoritedRecipes.contains(recipeUUID)
    }
    
    func getFavoriteRecipe(recipeUUID: String) -> Recipe? {
        return recipes.first { $0.uuid == recipeUUID }
    }
}
