//
//  ViewModel.swift
//  CityWeatherApp
//
//  Created by natarajan b on 9/22/24.
//

import Foundation

/// The root weather view model.
/// Saves and restores entered city or location specified as lat long to user defaults.
@Observable
final class WeatherViewModel : ObservableObject {
    var location: String = ""

    /// Initialize and if a city was saved, reload.
    init() {
        location = UserDefaults.standard.string(forKey:"city") ?? ""
    }
    
    /// Save the currently set location information in userdefaults, if it is non-null
    func save() {
        if (location.isEmpty) {
            return
        }
        UserDefaults.standard.set(location, forKey: "city")
    }
}
