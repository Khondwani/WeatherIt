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
	@StateObject private var weatherItViewModule: WeatherItViewModule

	//setup configuration
	init() {
		var configuration = Configuration()
		let locationSerice = LocationService()
		let internetMonitorService = InternetMonitorService()
		//Made it an environment object because It is a client that will be accesible on all screens.
		let weatherClient = WeatherClient(baseUrl: configuration.environment.weatherBaseURL)
		
		_weatherItViewModule = StateObject(wrappedValue: WeatherItViewModule( weatherRepository:  WeatherRepositoryImpl(weatherClient: weatherClient, locationServices: locationSerice, internetMonitorService: internetMonitorService)))
		
	}
	
    var body: some Scene {
        WindowGroup {
			WeatherItView().environmentObject(weatherItViewModule).environmentObject(themesManager)
        }
    }
}
