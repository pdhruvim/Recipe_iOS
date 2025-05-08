//
//  MalformedRecipeService.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 5/5/25.
//

import Foundation

class MalformedRecipeService: RecipeServiceProtocol {
    
    func fetchRecipes(url: String) async -> Result<[Recipe], RecipeError> {
        return .failure(.malformedRecipes)
    }
}
