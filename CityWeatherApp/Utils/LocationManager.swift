//
//  LocationManager.swift
//  CityWeatherApp
//
//  Created by natarajan b on 9/22/24.
//

import Foundation
import CoreLocation

/// The location manager with facilties to initialize the location
/// The location once enabled, continuously updates constrained by the user permission level choice
final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    func checkLocationAuthorization() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted: () // TODO
            
        case .denied: () // TODO
            
        case .authorizedAlways: () // TODO
            
        case .authorizedWhenInUse:
            lastKnownLocation = locationManager.location?.coordinate
            
        @unknown default: () // TODO
        }
    }
    
    /// Called when user changes mind about the kind of location authorization given
    /// - Parameter manager: OS  location manager
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {//Trigged every time authorization status changes
        checkLocationAuthorization()
    }
    
    /// Called when locations are updated by the OS
    /// - Parameters:
    ///   - manager: OS system location manager
    ///   - locations: The locations which also contains the lst known location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
