//
//  MockWeatherClient.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/26.
//

import Foundation
@testable import WeatherIt

class MockWeatherClient: WeatherClientProtocol {
	var shouldReturnError: Bool = false
	
	init(shouldReturnError: Bool) {
		self.shouldReturnError = shouldReturnError
	}
	
	func fetchCurrentWeather(location: WeatherIt.Location?) async throws -> WeatherIt.CurrentWeatherResponse? {
		if shouldReturnError {
			throw APIError.invalidResponse
		} else {
			return CurrentWeatherResponse(main: CurrentWeather(temp: 16.3, temp_min: 15.1, temp_max: 17.5), weather: [WeatherDescription(main: .Clear)])
		}
	}
	
	func fetchForecastWeather(location: WeatherIt.Location?) async throws -> WeatherIt.ForecastWeatherResponse? {
		if shouldReturnError {
			throw APIError.invalidResponse
		} else {
			return ForecastWeatherResponse(list: [ForecastDayDetails(dt_txt: "2025-01-22 21:00:00", main: WeatherDetails(temp: 15), weather: [WeatherDescription(main: .Rain)])])
		}
	}
	
	func fetchWeatherByCityName(for cityName: String) async throws -> WeatherIt.GeoCodingWeatherResponse? {
		return GeoCodingWeatherResponse(name: "Kitwe", coord: Location(lat: 0, lon: 0), weather: [WeatherDescription(main: .Clouds)], main: CurrentWeather(temp: 12, temp_min: 12, temp_max: 12))
	}
}
