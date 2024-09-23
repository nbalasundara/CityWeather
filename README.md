# CityWeather
The weather app is an app to get the latest weather for a given location.
The location is specified as  a city name or city name, state code for US cities.
The location is also automatically fetched if the user gives the app permission for location.
Currently there is the need to restart the app once the user provides the permission for
proper behavior for automatic location weather fetch.

The user can enter the city name of a US city to get the weather for the city. 

The last location city entry by user , or automatic(latitude, longitude) is automatically saved.
When the app restarts, the app fetches the weather for the location.

Perhaps if the weather is automatically fetched, maybe latitude and longitude should
not be persisted so the weather is always fetched from the server for the current location.
However this is not the at present(weather is fetched for the saved location). If such a change is required, it can be met with
easy code change.

The MVVM-C model is adapted for SwiftUI to the maximum extent possible without 
recourse to UIKit or Hosting view controllers, or UIKit navigation controllers. 
This is because most new functionalities are appearing in SwiftUI and Swift.
For example, Codable is only in Swift. As such it seems advantageous, to the extent 
possible, have most code in Swift and SwiftUI except when backward compatibility is needed.

Navigation and Navigation stacks, and the manager for the same, the Coordinator are
implemented using NavigationPath which gives us the ability to serialize the whole
navigation stack when the user quits the app and restore the exact state on relaunch.
Also this is so that we handle all navigation in SwiftUI itself.

