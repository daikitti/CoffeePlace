//
//  MenuCoffe.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 02.11.2024.
//

// MARK: - CoffePoint
struct MenuItem: Codable, Hashable {
    let id: Int
    let name, imageURL: String
    let price: Int
}

