//
//  EmptyRecipeService.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 5/6/25.
//

import Foundation

class EmptyRecipeService: RecipeServiceProtocol {
    
    func fetchRecipes(url: String) async -> Result<[Recipe], RecipeError> {
        return .success([])
    }
}
