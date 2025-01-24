//
//  WeatherItApp.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/18.
//

import SwiftUI

@main
struct WeatherItApp: App {
	// Themes
	@StateObject private var themesManager = ThemesManager()
	//setup EnvironmentObject
	@StateObject private var weatherItViewModel: WeatherItViewModel
	@StateObject private var favoritesViewModel: FavoritesViewModel

	//setup configuration
	init() {
		var configuration = Configuration()
		let locationSerice = LocationService()
		let internetMonitorService = InternetMonitorService()
		//Made it an environment object because It is a client that will be accesible on all screens.
		let weatherClient = WeatherClient(baseUrl: configuration.environment.weatherBaseURL)
		
		_weatherItViewModel = StateObject(wrappedValue: WeatherItViewModel( weatherRepository:  WeatherRepositoryImpl(weatherClient: weatherClient, locationServices: locationSerice, internetMonitorService: internetMonitorService)))
		
		_favoritesViewModel = StateObject(wrappedValue: FavoritesViewModel(favoriteWeatherRepository: FavoritesWeatherRepositoryImpl(weatherClient: weatherClient, internetMonitorService: internetMonitorService)))
		
	}
	
    var body: some Scene {
        WindowGroup {
			NavigationStack {
				WeatherItView()
			}.environmentObject(weatherItViewModel).environmentObject(favoritesViewModel).environmentObject(themesManager)
        }
    }
}
