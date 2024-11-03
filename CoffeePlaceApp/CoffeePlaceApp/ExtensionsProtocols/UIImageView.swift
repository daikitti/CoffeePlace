//
//  UIImageView.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 02.11.2024.
//

import UIKit


let imageCache = NSCache<NSString, UIImage>() // Кэш для хранения изображений

extension UIImageView {
    func setImage(from urlString: String, withLoader loader: UIActivityIndicatorView? = nil) {
        // Показываем лоадер
        loader?.startAnimating()
        
        // Проверяем кэш на наличие изображения
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
        
        // Задача для загрузки изображения
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // Останавливаем лоадер при ошибке
            if let error = error {
                print("Ошибка загрузки изображения: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    loader?.stopAnimating()
                }
                return
            }
            
            // Проверка полученных данных и создание изображения
            guard let data = data, let image = UIImage(data: data) else {
                print("Ошибка: Невозможно создать изображение из данных")
                DispatchQueue.main.async {
                    loader?.stopAnimating()
                }
                return
            }
            
            // Сохраняем изображение в кэш
            imageCache.setObject(image, forKey: urlString as NSString)
            
            // Обновляем UI в главном потоке
            DispatchQueue.main.async {
                self?.image = image
                loader?.stopAnimating() // Останавливаем лоадер после загрузки
            }
        }.resume()
    }
}
