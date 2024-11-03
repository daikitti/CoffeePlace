//
//  ApiManager.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 01.11.2024.
//

import Foundation


enum APIError: Error {
    case invalidURL
    case loginFailed
    case registrationFailed
    case unexpectedResponse
    case decodingError(Error)
    case unauthorized
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Ошибка URL"
        case .loginFailed:
            return "Ошибка с авторизацией"
        case .registrationFailed:
            return "Ошибка с регистрацией "
        case .unexpectedResponse:
            return "Ошибка - неожиданный ответ от сервера"
            
        case .decodingError(let error):
            return "---> Decoding error: \(error.localizedDescription)"
        case .unauthorized:
            return "проблемы с токеном"
        }
    }
}



class APIService {
    
    static let shared = APIService()
    
    func login(email: String, password: String) async throws {
        guard let url = URL(string: "http://147.78.66.203:3210/auth/login") else { throw APIError.invalidURL}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["login": email, "password": password]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        print(request)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.loginFailed
        }
        
        let result = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        if let token = result?["token"] as? String, let lifetime = result?["tokenLifetime"] as? Int {
            CheckAuthentication.shared.saveToken(token, lifetime: lifetime)
        }
    }
    
    func register(email: String, password: String) async throws {
        guard let url = URL(string: "http://147.78.66.203:3210/auth/register") else { throw APIError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["login": email, "password": password]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print(data, response)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.registrationFailed
        }
        
        let result = try JSONSerialization.jsonObject(with: data)
        print(result)
    }
    
    func getCoffePoints() async throws -> [CoffePoint] {
        guard let url = URL(string: "http://147.78.66.203:3210/locations") else { throw APIError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let token = CheckAuthentication.shared.getToken() else {
            throw APIError.loginFailed
        }
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, req) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = req as? HTTPURLResponse {
            if httpResponse.statusCode == 401 {
                print("Токен недействителен или истёк")
                throw APIError.unauthorized
            }
        }
            let locations = try JSONDecoder().decode([CoffePoint].self, from: data)
            return locations
    }
    
    func getMenu(for locationID: Int) async throws -> [MenuItem] {
        guard let url = URL(string: "http://147.78.66.203:3210/location/\(locationID)/menu") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let token = CheckAuthentication.shared.getToken() else {
            throw APIError.loginFailed
        }
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Печать данных для отладки
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Response JSON String: \(jsonString)")
        }
        
        // Проверяем статус ответа
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.unexpectedResponse
        }
        
        // Декодируем ответ в массив объектов MenuItem
        let menuItems = try JSONDecoder().decode([MenuItem].self, from: data)
        print(menuItems)
        return menuItems
    }
    
    
}
