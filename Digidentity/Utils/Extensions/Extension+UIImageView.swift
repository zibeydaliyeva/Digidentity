//
//  Extension+UIImageView.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 18.11.21.
//

import UIKit

extension UIImageView {

    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    func load(_ urlString: String) {
        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string: urlString),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            
            UIImageView.imageCache.setObject(
                image, forKey: urlString as AnyObject)
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }

    func loadImageFromUrl(_ urlString: String, placeholder: UIImage? = nil) {
        guard let urlTextEscaped = urlString.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed)
        else { return }
        
        let imageFromCache = UIImageView.imageCache.object(
            forKey: urlTextEscaped as AnyObject)
        
        if let imageFromCache = imageFromCache as? UIImage {
            self.image = imageFromCache
        } else {
            DispatchQueue.main.async {
                self.image = placeholder
            }
            self.load(urlTextEscaped)
        }
    }
    
}
