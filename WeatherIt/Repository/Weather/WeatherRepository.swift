//
//  WeatherRepository.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/22.
//

import Foundation

protocol WeatherRepository {
	// NOTE: CACHING THE RESPONSES FOR WHEN INTERNET ISNT AVAILABLE
	
	func saveCurrentWeather(currentWeather: CurrentWeatherResponse) async throws
	
	func saveCurrentForecastWeather(forecastWeather: ForecastWeatherResponse) async throws
	
	func getCurrentWeatherWithCurrentLocation(completion: @escaping (Result<CurrentWeatherResponse, Error>) -> Void) async throws

	func getForecastWeatherWithCurrentLocation(completion: @escaping (Result<ForecastWeatherResponse, Error>) -> Void) async throws
	
	func checkIfInternetConnectionAvailable() -> Bool
		
}

