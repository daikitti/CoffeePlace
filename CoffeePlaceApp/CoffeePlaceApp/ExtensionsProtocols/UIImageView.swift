//
//  UIImageView.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 02.11.2024.
//

import UIKit


let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func setImage(from urlString: String, withLoader loader: UIActivityIndicatorView? = nil) {
        loader?.startAnimating()
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            loader?.stopAnimating()
            return
        }
        
        guard let url = URL(string: urlString) else {
            print("Неправильный URL: \(urlString)")
            loader?.stopAnimating()
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Ошибка загрузки изображения: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    loader?.stopAnimating()
                }
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Ошибка: Невозможно создать изображение из данных")
                DispatchQueue.main.async {
                    loader?.stopAnimating()
                }
                return
            }
            
            imageCache.setObject(image, forKey: urlString as NSString)
            
            DispatchQueue.main.async {
                self?.image = image
                loader?.stopAnimating() 
            }
        }.resume()
    }
}
