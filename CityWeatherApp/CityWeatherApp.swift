//
//  CityWeatherAppApp.swift
//  CityWeatherApp
//
//  Created by natarajan b on 9/22/24.
//

import SwiftUI

/// Weather app shows weather.
///  The weather is gotten two ways
///     The user entering the city name in the US
///     From geo location of the current place
@main
struct CityWeatherApp: App {
    @UIApplicationDelegateAdaptor(CityWeatherAppDelegate.self) var appDelegate

    @State private var modelData = WeatherViewModel()
    @State private var weatherCordinator = WeatherCoordinator()

    var body: some Scene {
        WindowGroup {
            WeatherRootView()
        }
    }
}
