//
//  CacheImageService.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 5/7/25.
//

import Foundation
import SwiftUI

class CacheImageService: ImageDiskCacheProtocol {
    
    var image: Image? = nil
    
    func loadImageFromCache(recipeName: String) -> Image? {
        return image
    }
    
    func saveImageToCache(image: UIImage, recipeName: String) {
        self.image = Image(uiImage: image)
    }
}
