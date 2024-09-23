//
//  CityWeatherDataTest.swift
//  CityWeatherAppTests
//
//  Created by natarajan b on 9/22/24.
//

import XCTest


final class CityWeatherDataTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

 
    func testCityDeserialization() throws {
        decoder.keyDecodingStrategy = .convertFromSnakeCase;
        let cityWeatherData = """
        {"coord":{"lon":-0.1257,"lat":51.5085},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"base":"stations","main":{"temp":293.93,"feels_like":293.53,"temp_min":293.01,"temp_max":295.36,"pressure":1029,"humidity":56,"sea_level":1029,"grnd_level":1025},"visibility":10000,"wind":{"speed":6.17,"deg":70},"clouds":{"all":40},"dt":1726584028,"sys":{"type":2,"id":2075535,"country":"GB","sunrise":1726551547,"sunset":1726596651},"timezone":3600,"id":2643743,"name":"London","cod":200}
        """
        
        let refWeatherData = CityWeatherData(coord: Coords(lon:-0.1257, lat:51.5085), weather: [Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: "03d")], base: "stations", main: MainWeather(temp: 293.93, feelsLike: 293.53, tempMin: 293.01, tempMax: 295.36, pressure: 1029, humidity: 56, seaLevel: 1029, grndLevel: 1025), visibility: 10000, wind: Wind(speed: 670, deg: 70), clouds: Clouds(all: 40), dt: 1726584028, sys: Sys(type: 2, id:2075535, country: "GB", sunrise: 1726551547, sunset: 1726596651), timezone: 3600, id: 2643743, name: "London", cod: 200)

        let weatherData = try decoder.decode(CityWeatherData.self, from: cityWeatherData.data(using: .utf8)!)
        
        // TODO Ideally we would implement Equatable and XCTAssertEqual(refWeatherData, weatherData, "The deserialized weather data incorrect")
        // Here we just check a few fields in code but verify each field is right in debugger, manually.
        XCTAssert(refWeatherData.weather[0].id == weatherData.weather[0].id
                  && refWeatherData.sys.country == weatherData.sys.country
                  && refWeatherData.name == weatherData.name, "The deserialized weather data is incorrect")
    }
    
    
    func testCoordDeserialization() throws {
        let coordWeatherData = """
        {"coord":{"lon":-10,"lat":10},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"base":"stations","main":{"temp":302.28,"feels_like":305.6,"temp_min":302.28,"temp_max":302.28,"pressure":1009,"humidity":67,"sea_level":1009,"grnd_level":960},"visibility":10000,"wind":{"speed":1.58,"deg":339,"gust":2.1},"rain":{"1h":0.25},"clouds":{"all":77},"dt":1727104352,"sys":{"country":"GN","sunrise":1727072944,"sunset":1727116528},"timezone":0,"id":2414659,"name":"Tokonou","cod":200}
        """
        let refWeatherData = CityWeatherData(coord: Coords(lon:-0.1257, lat:51.5085), weather: [Weather(id: 802, main: "Clouds", description: "scattered clouds", icon: "03d")], base: "stations", main: MainWeather(temp: 293.93, feelsLike: 293.53, tempMin: 293.01, tempMax: 295.36, pressure: 1029, humidity: 56, seaLevel: 1029, grndLevel: 1025), visibility: 10000, wind: Wind(speed: 670, deg: 70), clouds: Clouds(all: 40), dt: 1726584028, sys: Sys(type: nil, id:nil, country: "GB", sunrise: 1726551547, sunset: 1726596651), timezone: 3600, id: 2643743, name: "London", cod: 200)

        let weatherData = try decoder.decode(CityWeatherData.self, from: coordWeatherData.data(using: .utf8)!)
        XCTAssert(refWeatherData.weather[0].id == weatherData.weather[0].id
                  && refWeatherData.sys.country == weatherData.sys.country
                  && refWeatherData.name == weatherData.name, "The deserialized weather data is incorrect")    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
