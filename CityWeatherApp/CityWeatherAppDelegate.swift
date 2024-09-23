//
//  CityWeatherAppDelegate.swift
//  CityWeatherApp
//
//  Created by natarajan b on 9/23/24.
//

import UIKit
import CoreLocation

/// Custom delegate to initialize location manager
class CityWeatherAppDelegate: NSObject, UIApplicationDelegate {
    static let locationManager : LocationManager = LocationManager()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Set up location tracking
        CityWeatherAppDelegate.locationManager.checkLocationAuthorization()
        if let lastKnownLocation = CityWeatherAppDelegate.locationManager.lastKnownLocation {
        }
        return true
    }
}
