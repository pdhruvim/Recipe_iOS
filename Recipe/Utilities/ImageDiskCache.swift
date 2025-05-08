//
//  ImageDiskCache.swift
//  Recipe
//
//  Created by Dhruv Harry Patel on 5/7/25.
//

import Foundation
import SwiftUI
import UIKit

protocol ImageDiskCacheProtocol {
    func saveImageToCache(image: UIImage, recipeName: String)
    func loadImageFromCache(recipeName: String) -> Image?
}

class ImageDiskCache: ImageDiskCacheProtocol {
    
    // a singleton and shared class
    static let shared = ImageDiskCache()
    
    private let cacheDirectory: URL
    private let maxCacheSize = 1 * 1024 * 1024 // 1 MB
    
    // private init so it cannot be initialize anywhere in the code
    private init() {
        cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("recipe_images")
    }
    
    // creates a directory if not present in the cachesDirectory folder
    private func createDirectory() {
        if !FileManager.default.fileExists(atPath: cacheDirectory.path) {
            do {
                try FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
            } catch {
                print("Creating directory failed: \(error.localizedDescription)")
            }
        }
    }
    
    // saves Image to Cache by creation date
    func saveImageToCache(image: UIImage, recipeName: String) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        let imagePath = cacheDirectory.appendingPathComponent("\(recipeName).jpg")
        
        do {
            try imageData.write(to: imagePath)
            try FileManager.default.setAttributes([.creationDate: Date()], ofItemAtPath: imagePath.path)
            checkCacheLimits()
        } catch {
            print("Saving image failed: \(error.localizedDescription)")
        }
    }
    
    // load and returns Image from Cache
    func loadImageFromCache(recipeName: String) -> Image? {
        let imagePath = cacheDirectory.appendingPathComponent("\(recipeName).jpg")
        guard FileManager.default.fileExists(atPath: imagePath.path) else { return nil }
        
        if let uiImage = UIImage(contentsOfFile: imagePath.path) {
            return Image(uiImage: uiImage)
        }
        
        return nil
    }
    
    // Cache Management function to avoid going over max Cache limit of 1 MB
    private func checkCacheLimits() {
        // gets all Image URLs including creation date and file size
        guard let imageURLs = try? FileManager.default.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: [.creationDateKey, .fileSizeKey], options: .skipsHiddenFiles) else { return }
        
        var fileInformations: [(url: URL, creationDate: Date, fileSize: Int)] = []
        var currentCacheSize = 0
        
        for imageURL in imageURLs {
            // retrives creation date and file size
            if let attributes = try? imageURL.resourceValues(forKeys: [.creationDateKey, .fileSizeKey]),
               let date = attributes.creationDate,
               let size = attributes.fileSize {
                fileInformations.append((imageURL, date, size))
                // adding all file size to check if we are under max Cache limit
                currentCacheSize += size
            }
        }
        
        // if under max Cache limit, then return early
        if currentCacheSize < maxCacheSize { return }
        
        // sorting Image URLs by creation date to evict oldest URL
        let sortedFileInformations = fileInformations.sorted { $0.creationDate < $1.creationDate }
        
        for fileInfo in sortedFileInformations {
            try? FileManager.default.removeItem(at: fileInfo.url)
            currentCacheSize -= fileInfo.fileSize
            
            if currentCacheSize <= maxCacheSize { break }
        }
    }
}
