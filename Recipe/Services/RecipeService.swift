//
//  RecipeService.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 4/30/25.
//

import Foundation

enum RecipeError: Error {
    case malformedRecipes
    case invalidURL
    case networkError(Error)
}

protocol RecipeServiceProtocol {
    func fetchRecipes(url: String) async -> Result<[Recipe], RecipeError>
}

class RecipeService: RecipeServiceProtocol {
    
    func fetchRecipes(url: String) async -> Result<[Recipe], RecipeError> {
        do {
            guard let localURL = URL(string: url) else { return .failure(.invalidURL) }
            // as URLSession caches URL, I manually stopped it from caching to make sure it makes a network call every time
            let request = URLRequest(url: localURL, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let decoded = try? JSONDecoder().decode(RecipeResponse.self, from: data) else {
                return .failure(.malformedRecipes)
            }
            return .success(decoded.recipes)
        } catch {
            return .failure(.networkError(error))
        }
    }
}
