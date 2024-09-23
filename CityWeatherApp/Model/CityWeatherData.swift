
//  CityWeather.swift
//  CityWeatherApp
//
//  Created by natarajan b on 9/22/24.
//

import Foundation
import Combine

let decoder = JSONDecoder()

enum WeatherFetchError: Error {
    case unexpected
    case noData
    case invalidUrl(_ url: String)
    case api(statusCode: Int)
    case http(statusCode: Int?)
    case jsonParsingError(_ error: String)
    case unknownServerError
}

struct Coords: Codable {
    var lon: Float
    var lat: Float
}

struct Weather: Codable, Identifiable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct MainWeather: Codable {
    var temp: Float
    var feelsLike: Float
    var tempMin: Float
    var tempMax: Float
    var pressure: Float
    var humidity: Float
    var seaLevel: Float
    var grndLevel: Float
}

struct Wind: Codable {
    var speed: Float
    var deg: Float
}

struct Clouds: Codable {
    var all: Float
}

struct Sys: Codable {
    var type: Int? // Not present if the location is specified as lat lonng
    var id: Int? // Not present if the location is specified as lat lonng
    var country: String
    var sunrise: Int
    var sunset: Int
}

struct LatLonSys: Codable {
    var country: String
    var sunrise: Int
    var sunset: Int
}

struct LatLongWeatherData: Codable {
    var coord: Coords
    var weather: [Weather]
    var base: String
    var main: MainWeather
    var visibility: Float
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var sys: LatLonSys
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
    
}

/// The deserializable data structure for weather
struct CityWeatherData: Codable {
    var coord: Coords
    var weather: [Weather]
    var base: String
    var main: MainWeather
    var visibility: Float
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var sys: Sys
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
    
    /// Asynchronously updates the current weather for a location
    /// - Parameters:
    ///   - city: Either a city name or latitude and longitude
    ///   - updateWeather: The callback when either the weather is data is gotten successfully or it fails.
    /// - Returns: calls the updateweather callback with the result of the asynchronous fetch of the weather for a given location.
    ///
    static func getWeather(for location: String, updateWeather:@Sendable @escaping (CityWeatherData?, Error?) -> Void) -> Void {
            
        var urlString = "https://api.openweathermap.org/data/2.5/weather?q=" + location + ",us&APPID=ded4350607c026877ca5d400f056d3a7"
        
        if (location.lowercased().starts(with: "lat=")) {
            urlString = "https://api.openweathermap.org/data/2.5/weather?" + location.lowercased() + "&APPID=ded4350607c026877ca5d400f056d3a7"
        }
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                updateWeather(nil, WeatherFetchError.invalidUrl(urlString))
            }
            return
        }
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            if error != nil || data == nil {
                DispatchQueue.main.async {
                    updateWeather(nil, WeatherFetchError.noData)
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    updateWeather(nil, WeatherFetchError.unexpected)
                }
                return
            }
            
            if !(200...299).contains(response.statusCode) {
                DispatchQueue.main.async {
                    updateWeather(nil, WeatherFetchError.http(statusCode:response.statusCode))
                }
                return
            }
            
            do {
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weatherData = try decoder.decode(CityWeatherData.self, from: data!)
                DispatchQueue.main.async {
                    updateWeather(weatherData, nil)
                    return
                }
            } catch let parseError {
                DispatchQueue.main.async {
                    updateWeather(nil, WeatherFetchError.jsonParsingError(parseError.localizedDescription))
                }
                return
            }
        }
        task.resume()
    }
}





