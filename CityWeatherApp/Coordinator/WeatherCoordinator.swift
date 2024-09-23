//
//  WeatherCoordinator.swift
//  CityWeatherApp
//
//  Created by natarajan b on 9/22/24.
//
import SwiftUI

/// The navigation stack element
/// Note that it is possible to serialize and deserialize the contents
/// so that if the app were to develop into complex app, the current navigation
/// state of the entire app can be serialized out and on restart of the app deserialized back in.
struct NavStackCity : Codable, Identifiable, Equatable, Hashable {
    let id: UUID
    var name : String
    
    init(_ cityName: String) {
        id = UUID()
        name = cityName
    }
}

/// The navigation coordinator.
/// Views observe the path, and if it were to change, navigation gets triggerd
class WeatherCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    /// Directs navigation to the location weather detail view
    /// - Parameter location: location for which the detail view is needed
    func showDetail(location: NavStackCity) {
        path.append(location)
    }
    
    /// Currently on top view is popped
    func pop() {
        path.removeLast()
    }
    
    /// The view moves back to the root view
    func popToRoot() {
        path.removeLast(path.count)
    }
}
