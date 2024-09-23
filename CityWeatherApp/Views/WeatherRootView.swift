//
//  ContentView.swift
//  CityWeatherApp
//
//  Created by natarajan b on 9/22/24.
//

import SwiftUI

/// The root view of the view hierarchy
/// Initializes the coordinator that will manage view navigation
struct WeatherRootView: View {
    @StateObject private var coordinator = WeatherCoordinator()
    @StateObject private var weatherVewModel = WeatherViewModel()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack(alignment: .center) {
                    Text("Enter a US City Name")
                    TextField("City", text:($weatherVewModel.location)).accessibilityAction {
                        //TODO
                    }.onSubmit {
                        if (weatherVewModel.location.isEmpty) {
                            Text("City name is empty. Please enter a city name")
                        } else {
                            weatherVewModel.save()
                            coordinator.showDetail(location: NavStackCity(weatherVewModel.location))
                        }
                    }.navigationDestination(for: NavStackCity.self) { city in
                        WeatherDetailView(city:city)
                    }
               
            }.navigationTitle("City Weather")
        }.onAppear {
            if (weatherVewModel.location.isEmpty) {
                if let coordinate = CityWeatherAppDelegate.locationManager.lastKnownLocation {
                    weatherVewModel.location = "lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
                    if !weatherVewModel.location.isEmpty {
                        weatherVewModel.save()
                        coordinator.showDetail(location: NavStackCity(weatherVewModel.location))
                    }
                }
            } else {
                coordinator.showDetail(location: NavStackCity(weatherVewModel.location))
            }
        }
    }
}

#Preview {
    WeatherRootView()
}
