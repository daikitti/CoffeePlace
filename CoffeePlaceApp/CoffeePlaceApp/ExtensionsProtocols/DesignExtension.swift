//
//  DesignExtension.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 31.10.2024.
//

import UIKit

//MARK: протокол для дизайн
protocol Designable{
    func setupUP()
    func addSubviews()
    func setupConstraints()
}

//MARK: кастомные цвета
struct CustomColors{
    static let blackBrown = UIColor(hexString: "230C02")
    static let whiteBrown = UIColor(hexString: "FFF5E9")
    static let gray = UIColor(hexString: "FFF5E9").withAlphaComponent(0.7)
    static let green = UIColor(hexString: "469E6D")
    
    
}

//MARK: расширение для получения цвета по hex
extension UIColor{
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

//MARK: полная заливака/контур кнопки 
extension UIButton {
    func switchEnable(totalPrice: Int) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            if totalPrice == 0 {
                self.setTitleColor(CustomColors.blackBrown, for: .normal)
                self.backgroundColor = .clear
                self.layer.borderWidth = 2
                self.layer.borderColor = CustomColors.blackBrown.cgColor
            } else {
                self.setTitleColor(CustomColors.whiteBrown, for: .normal)
                self.backgroundColor = CustomColors.blackBrown
                self.layer.borderColor = UIColor.clear.cgColor
            }
            self.layoutIfNeeded()
        }
    }
    
}
