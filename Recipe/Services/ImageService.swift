//
//  ImageService.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 5/2/25.
//

import Foundation
import SwiftUI

class ImageService {
    
    private let imageCache: ImageDiskCacheProtocol!
    private let netManager: NetworkManagerProtocol!
    
    // dependency injection for testing
    init(imageCache: ImageDiskCacheProtocol, netManager: NetworkManagerProtocol) {
        self.imageCache = imageCache
        self.netManager = netManager
    }
    
    func getImage(recipeName: String, photoURL: String?) async -> Image? {
        // load and returns Image from Cache if present
        if let localImage = imageCache.loadImageFromCache(recipeName: recipeName) {
            return localImage
        }
        
        // if not present in Cache, then makes a network call
        do {
            guard let image = try await netManager.fetchImageFromServer(recipeName: recipeName, photoURL: photoURL) else { return nil }
            // saves the Image in Cache for future load
            imageCache.saveImageToCache(image: image, recipeName: recipeName)
            return Image(uiImage: image)
        } catch {
            print("Fetching image failed: \(error.localizedDescription)")
            return nil
        }
    }
}
