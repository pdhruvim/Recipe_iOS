//
//  NetworkFetchImageService.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 5/7/25.
//

import Foundation
import SwiftUI

class NetworkFetchImageService: NetworkManagerProtocol {
    
    func fetchImageFromServer(recipeName: String, photoURL: String?) async throws -> UIImage? {
        return UIImage(systemName: "server.rack")
    }
}
