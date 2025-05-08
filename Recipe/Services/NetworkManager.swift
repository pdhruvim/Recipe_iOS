//
//  NetworkManager.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 5/7/25.
//

import Foundation
import SwiftUI

protocol NetworkManagerProtocol {
    func fetchImageFromServer(recipeName: String, photoURL: String?) async throws -> UIImage?
}

class NetworkManager: NetworkManagerProtocol {
    
    // a singleton and shared class
    static let shared = NetworkManager()
    
    // private init so it cannot be initialize anywhere in the code
    private init() { }
    
    // returns an Image from network call
    func fetchImageFromServer(recipeName: String, photoURL: String?) async throws -> UIImage? {
        guard let photoURL = photoURL,
              let url = URL(string: photoURL) else { return nil }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let uiImage = UIImage(data: data) else { return nil }
        return uiImage
    }
}
