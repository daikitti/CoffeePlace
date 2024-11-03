//
//  GpsManager.swift
//  CoffeePlaceApp
//
//  Created by Havydope Diii on 03.11.2024.
//

import CoreLocation

class GpsManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = GpsManager()
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() //  разрешение
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //точность
    }
    
    func requestCurrentLocation(){
        locationManager.requestLocation() // текущее местоположение
    }
    
    func getCurrentLocation() -> CLLocation? {
        return currentLocation
    }
    
    func getDistanceToPoint(point: Point) -> String {
        guard let userLocation = currentLocation, let latitude = Double(point.latitude) , let longitude = Double(point.longitude) else {
            return "Неизвестное местоположение"
        }
        let point = CLLocation(latitude:latitude, longitude: longitude)
        
        let distanceInMeters = userLocation.distance(from: point)
        
        if distanceInMeters < 1000 {
               return String(format: "%.0f м от вас", distanceInMeters)
           } else {
               let distanceInKilometers = distanceInMeters / 1000
               return String(format: "%.1f км от вас", distanceInKilometers)
           }
    }
    
    
    //Делегаты
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        print("Текущее местоположение: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ошибка получения местоположения: \(error.localizedDescription)")
    }
    
   
}
