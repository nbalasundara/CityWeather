//
//  Untitled.swift
//  CityWeatherApp
//
//  Created by natarajan b on 9/22/24.
//

import SwiftUI

/// Shows the detailed weather for a user selected location
struct WeatherDetailView: View {
    private let weatherDetailViewModel = WeatherDetailViewModel()
    private var city: NavStackCity
    
    init(city: NavStackCity) {
        self.init(city: city, weatherDetail: nil)
    }
    
    init(city: NavStackCity, weatherDetail: CityWeatherData?) { // TODO For testing purposes
        self.city = city
        weatherDetailViewModel.location = city.name
        weatherDetailViewModel.cityWeatherData = weatherDetail
    }
    
    func refreshWeatherData() {
        weatherDetailViewModel.refreshCityWeather()
    }
    
    var body: some View {
        NavigationView {
            if let wd = self.weatherDetailViewModel.cityWeatherData {
                VStack(alignment: .center) {
                    Text("Latitude: \(wd.coord.lat) Longitude: \(wd.coord.lon)")
                    ForEach (wd.weather) { w in
                        Text("\(w.id) \(w.main) \(w.description)")
                        //
                        // If needed set URLCache settings for how much caching we want
                        // to do for Async Images, to store them locally:
                        // URLCache.shared.memoryCapacity = 50_000_000 // ~50 MB memory space
                        // URLCache.shared.diskCapacity = 1_000_000_000 // ~1GB disk cache space
//                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/" + w.icon +  "@2x.png")).frame(width: 100, height: 100)
//                        placeholder: do {
//                            ProgressView()
//                        }
                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/" + w.icon +  "@2x.png")) { phase in
                            if let image = phase.image {
                                image.resizable()
                            } /* TODO else if phase.error != nil {
                                Image("placeholderImage")
                            } */ else {
                                ProgressView().progressViewStyle(.circular)
                            }
                        }.frame(width: 100, height: 100)
                    }
                
                    // Main weather
                    Text("Temperature: \(wd.main.temp)")
                    Text("Feels like: \(wd.main.feelsLike)")
                    Text("Minimum temperature: \(wd.main.tempMin)")
                    Text("Maximum temperature: \(wd.main.tempMax)")
                    Text("Pressure: \(wd.main.pressure)")
                    Text("Humidity: \(wd.main.humidity)")
                    Text("Sea level: \(wd.main.seaLevel)")
                    Text("Ground level: \(wd.main.grndLevel)")
                    // visibility
                    Text("Wind: \(wd.visibility)")
                    // Wind
                    Text("Wind speed: \(wd.wind.speed)")
                    Text("Wind direction: \(wd.wind.deg) degrees")
                    // Clounds
                    Text("Clouds: \(wd.clouds.all)")
                    Text("dt: \(wd.dt)")
                    if let t = wd.sys.type {
                        Text("System type: \(t)")
                    }
                    if let d = wd.sys.id {
                        Text("System id: \(d)")
                    }
                    Text("System country: \(wd.sys.country)")
                    Text("System sunrise: \(wd.sys.sunrise)")
                    Text("System sunset: \(wd.sys.sunset)")
                    Text("Time zone: \(wd.timezone)")
                    Text("id: \(wd.id)")
                    Text("cod: \(wd.cod)")
                }
            } else {
               Text("Fetching weather data for " + city.name)
               ProgressView()
           }
        }
    }
}

#Preview {
    WeatherDetailView(city: NavStackCity("London"), weatherDetail:CityWeatherData(coord: Coords(lon:-0.1257, lat:51.5085), weather: [Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: "03d")], base: "stations", main: MainWeather(temp: 293.93, feelsLike: 293.53, tempMin: 293.01, tempMax: 295.36, pressure: 1029, humidity: 56, seaLevel: 1029, grndLevel: 1025), visibility: 10000, wind: Wind(speed: 670, deg: 70), clouds: Clouds(all: 40), dt: 1726584028, sys: Sys(type: 2, id:2075535, country: "GB", sunrise: 1726551547, sunset: 1726596651), timezone: 3600, id: 2643743, name: "London", cod: 200))
}
