//
//  URLImageModel.swift
//  XMoviesProject
//
//  Created by Denis on 4/4/23.
//

import Foundation
import SwiftUI
class UrlImageModel: ObservableObject {
    @Published var image: UIImage?
    var imageCache = ImageCache.getImageCache()
    var urlString: String?
    
    init(urlString: String? = nil) {
        self.urlString = urlString
       loadImage()
    }
    func loadImage() {
        print("Cache hit loading Image from Cache")
        if loadImageFromCache() {
            return
        }
        print("Cache miss loading Image from URL")
            loadImageFromUrl()
    }
    
    func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }
        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        
        image = cacheImage
        return true
        
    }
    
    func loadImageFromUrl() {
        guard let urlString = urlString else {
            return
        }
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url,completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    }
    func getImageFromResponse(data:Data?,response:URLResponse?,error:Error?) {
        
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard  let data = data else {
            print("Not found Data")
            return
        }
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            self.imageCache.set(forKey: self.urlString!, image: loadedImage)
            self.image = loadedImage
        }
    }
}

class ImageCache {
    var cache = NSCache<NSString,UIImage>()
    
    func get(forKey:String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey:String,image:UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
    
}
extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
