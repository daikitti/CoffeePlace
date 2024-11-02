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
        
        // Дополнительная обработка данных, если нужно
         let result = try JSONSerialization.jsonObject(with: data)
        print(result)
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
        
        // Дополнительная обработка данных, если нужно
        let result = try JSONSerialization.jsonObject(with: data)
        print(result)
    }
}
