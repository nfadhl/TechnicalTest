//
//  ImageCache.swift
//  TechnicalTest
//
//  Created by Fadhl Nader on 29/08/2024.
//

import Foundation
import UIKit

final class ImageCache {
    
    static let shared = ImageCache()
    
    private init() {
        // Private initializer to enforce singleton pattern
    }
    
    private let urlCache: URLCache = {
        let memoryCapacity = 50 * 1024 * 1024 // 50 MB
        let diskCapacity = 100 * 1024 * 1024 // 100 MB
        return URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "imageCache")
    }()
    
    private lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = self.urlCache
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration)
    }()
    
    func loadImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        let request = URLRequest(url: url)
        
        if let cachedResponse = urlCache.cachedResponse(for: request) {
            // Image is in cache, return it
            if let image = UIImage(data: cachedResponse.data) {
                completion(image)
            } else {
                completion(nil)
            }
        } else {
            // Image not in cache, download and cache it
            let task = urlSession.dataTask(with: request) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    let cachedResponse = CachedURLResponse(response: response!, data: data)
                    self.urlCache.storeCachedResponse(cachedResponse, for: request)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
            task.resume()
        }
    }
}


