//
//  checkAuthentication.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 02.11.2024.
//

import Foundation


//MARK: сохранение токена и его получение
final class CheckAuthentication{
    static let shared = CheckAuthentication()
    private init() {}
    
    func saveToken(_ token: String, lifetime: Int) {
        let EndDate = Date().addingTimeInterval(TimeInterval(lifetime/1000))
        UserDefaults.standard.set(token, forKey: "authToken")
        UserDefaults.standard.set(EndDate, forKey: "tokenEndDate")
    }
    
    func getToken() -> String? {
        guard let EndDate = UserDefaults.standard.object(forKey: "tokenEndDate") as? Date,
              EndDate > Date() else {
            
            UserDefaults.standard.removeObject(forKey: "authToken")
            UserDefaults.standard.removeObject(forKey: "tokenEndDate")
            return nil
        }
        print( EndDate , "<", Date())
        return UserDefaults.standard.string(forKey: "authToken")
    }
}
