//
//  WeatherClientProtocol.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/26.
//

import Foundation

protocol WeatherClientProtocol {
	
	func fetchCurrentWeather(location: Location?) async throws -> CurrentWeatherResponse?
	func fetchForecastWeather(location: Location?) async throws -> ForecastWeatherResponse?
	func fetchWeatherByCityName(for cityName: String) async throws -> GeoCodingWeatherResponse?
}
