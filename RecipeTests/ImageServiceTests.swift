//
//  ImageServiceTests.swift
//  RecipeTests
//
//  Created by Dhruv Harry Patel on 5/7/25.
//

import XCTest
@testable import Recipe

final class ImageServiceTests: XCTestCase {
    
    func test_cacheImageService() async {
        // Arrange
        let mockCacheImageService = CacheImageService()
        let mockNetworkImageService = NetworkFetchImageService()
        let imageService = ImageService(imageCache: mockCacheImageService, netManager: mockNetworkImageService) // injecting Mock data for testing
        let mockImage = UIImage(systemName: "heart.fill")!
        
        // Act
        // Since we are testing loading from Cache, we need an Image to be present already
        mockCacheImageService.saveImageToCache(image: UIImage(systemName: "heart.fill")!, recipeName: "") // calling CacheImageService.save
        let image = await imageService.getImage(recipeName: "", photoURL: "")
        
        // Assert
        XCTAssertNotNil(image)
    }
    
    func test_networkFetchImageService() async {
        // Arrange
        let mockCacheImageService = CacheImageService()
        let mockNetworkImageService = NetworkFetchImageService()
        let imageService = ImageService(imageCache: mockCacheImageService, netManager: mockNetworkImageService)
        
        // Act
        // we are not calling saveImageToCache function, so loadImageFromCache will return nil
        // Hence it will make a network call
        let image = await imageService.getImage(recipeName: "", photoURL: "")
        
        // Assert
        XCTAssertNotNil(image)
    }
}
