//
//  Recipe.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 4/30/25.
//

import Foundation

struct Recipe: Decodable, Equatable, Identifiable {
    let cuisine: String
    let name: String
    let photo_url_small: String?
    let uuid: String
    
    var id: UUID {
        UUID(uuidString: uuid) ?? UUID()
    }
}
