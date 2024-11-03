//
//  CoffePoint.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 02.11.2024.
//

import Foundation

// MARK: - CoffePoint
struct CoffePoint: Codable {
    let id: Int
    let name: String
    let point: Point
}

// MARK: - Point
struct Point: Codable {
    let latitude, longitude: String
}

