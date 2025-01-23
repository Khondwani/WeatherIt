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
	// NOTE: FOR EXTRA WORK
	func getCurrentWeatherWithCityName(_ cityName: String, completion: @escaping (Result<CurrentWeatherResponse, Error>) -> Void)

	func getForecastWeatherWithCurrentLocation(completion: @escaping (Result<ForecastWeatherResponse, Error>) -> Void) async throws
	// NOTE: FOR EXTRA WORK
	func getForecastWeatherWithCityName(_ cityName: String, completion: @escaping (Result<ForecastWeatherResponse, Error>) -> Void)
	
	func checkIfInternetConnectionAvailable() -> Bool
		
}

