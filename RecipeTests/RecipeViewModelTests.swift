//
//  RecipeViewModelTests.swift
//  RecipeTests
//
//  Created by Dhruv Harry Patel on 5/5/25.
//

import XCTest
@testable import Recipe

final class RecipeViewModelTests: XCTestCase {
    
    func test_fetchRecipes_malformedRecipes() async {
        // Arrange
        let mockMalformedRecipes = MalformedRecipeService()
        // MalformedRecipeService() returns a failure of type .malformedRecipes
        let recipeService = RecipeViewModel(recipeService: mockMalformedRecipes)
        
        // Act
        await recipeService.loadRecipes() // loading recipes will assign our statusMessage to be Invalid Response
        
        // Assert
        XCTAssertEqual("Invalid response", recipeService.statusMessage)
        XCTAssertEqual(0, recipeService.recipes.count)
    }
    
    func test_fetchRecipes_emptyRecipes() async {
        // Arrange
        let mockEmptyRecipes = EmptyRecipeService()
        // EmptyRecipeService() returns a success with [] array
        let recipeService = RecipeViewModel(recipeService: mockEmptyRecipes)
        
        // Act
        await recipeService.loadRecipes() // loading recipes will assign our statusMessage to be "There are no recipes."
        // loadRecipes will return []
        
        // Assert
        XCTAssertEqual("There are no recipes.", recipeService.statusMessage)
        XCTAssertEqual(0, recipeService.recipes.count)
    }
}
