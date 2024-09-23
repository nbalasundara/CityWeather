//
//  WeatehrDetailViewModel.swift
//  CityWeatherApp
//
//  Created by natarajan b on 9/22/24.
//
import Foundation

/// The view model for the detailed weather for a given location.
@Observable
class WeatherDetailViewModel : ObservableObject {
    private var _city: String?
    var cityWeatherData: CityWeatherData?
    var weatherFetchError: WeatherFetchError?
    
    /// The location is either a city name or lat long.
    /// When the city is updated, it automatically triggers weather fetch
    var location: String? {
        get {
            return _city
        }
        set {
            _city = newValue
            refreshCityWeather()
        }
    }
    
    /// Initializer which initializes all values to nill
    init() {
        _city = nil
        cityWeatherData = nil
        weatherFetchError = nil
    }
    
    /// Method when called triggers update of the model asynchronously
    /// - Returns: Void
    func refreshCityWeather() -> Void {
        if let city = _city {
            CityWeatherData.getWeather(for: city) { cityWeatherData, error in
                if error == nil {
                    self.cityWeatherData = cityWeatherData
                    return
                }
                if error is WeatherFetchError {
                    self.weatherFetchError = error as? WeatherFetchError
                    return
                }
            }
        }
    }
}
