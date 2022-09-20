//
//  ImageLoader.swift
//  TestDecisionRules
//
//  Created by efloresco on 09/09/22.
//

import Foundation
import UIKit
class ImageLoader: UIImageView {
    func setViewImage(stringUrlToImage: String?) {
        guard let stringUrlToImage = stringUrlToImage, let urlToImage = URL(string: stringUrlToImage) else {
            return self.image = nil
        }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: urlToImage)) {
            self.image = UIImage(data: cachedResponse.data)
            return
        }
        
        let urlSessionDataTask = URLSession.shared.dataTask(with: urlToImage) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    self?.imageToCache(data: data, response: response)
                }
            }
        }
        urlSessionDataTask.resume()
    }
    
    private func imageToCache(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
