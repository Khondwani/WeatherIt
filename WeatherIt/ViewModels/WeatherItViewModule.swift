//
//  WeatherItViewModule.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/20.
//

import Foundation
@MainActor
class WeatherItViewModule: ObservableObject {
	@Published private(set) var currentWeather: CurrentWeatherResponse? = nil
	@Published private(set) var forecastWeather: [ForecastDayDetails]? = []
	
	let weatherClient: WeatherClient // so that we are able to move the weatherClient
	let locationServices: LocationService
	init(weatherClient: WeatherClient, locationService: LocationService) {
		self.weatherClient = weatherClient
		self.locationServices = locationService
	}
	// business logic
	func getCurrentWeather() async throws {
		 currentWeather = try await weatherClient.fetchCurrentWeather(location: locationServices.getCurrentLocation()!)
	}
	
	func getForecastWeather() async throws {
		let forecastWeatherList = try await weatherClient.fetchForecastWeather(location: locationServices.getCurrentLocation()!)
		// We only get the next 5 dates after current date. We also consider the time,
		// So if its 12:30 we get the time 12:00:00, if its 13:00:00 we also get 12:00:00
		forecastWeather = forecastWeatherList?.list.filter {
			var timeDateFormatter = DateFormatter()
			timeDateFormatter.dateFormat = "HH:mm:ss"   // HH for 24h clock
			let date = Date()
			let timeString = timeDateFormatter.string(from: date)
			return $0.dt_txt.contains(timeString)
		}
	}
	
	func getCurrentTemp()->String{
		guard let currentWeather = currentWeather else {
			return "-"
		}
		return String(format: "%.f",currentWeather.main.temp) // no decimals
	}
	
	func getCurrentWeatherType() -> WeatherType {
		guard let currentWeather = currentWeather else {
			return .Clear
		}
		return currentWeather.weather[0].main
	}
	
	func getCurrentWeatherTitle() -> String {
		guard let currentWeather = currentWeather else {
			return "-"
		}
		switch currentWeather.weather[0].main {
			case .Clear:
				return "sunny"
			case .Clouds:
				return "cloudy"
			case .Rain:
				return "rainy"
		}
	}
	
	func getCurrentWeatherMinTemp() -> String {
		guard let currentWeather = currentWeather else {
			return "-"
		}
		return String(format: "%.f",currentWeather.main.temp_min) 
	}
	
	func getCurrentWeatherMaxTemp() -> String {
		guard let currentWeather = currentWeather else {
			return "-"
		}
		return String(format: "%.f",currentWeather.main.temp_max)
	}
}
