//
//  MockWeatherRepository.swift
//  MockWeatherRepository
//
//  Created by Khondwani Sikasote on 2025/01/26.
//

import Foundation
@testable import WeatherIt

class MockWeatherRepositoryImpl: WeatherRepository {
	
	var currrentWeatherStorage: [CurrentWeatherResponse] = [] // WHERE WE MOCK SAVING
	var forecastWeatherStorage: [ForecastWeatherResponse] = []
	
	var weatherClient: WeatherClientProtocol
	
	init(weatherClient:WeatherClientProtocol){
		self.weatherClient = weatherClient
	}
	
	func saveCurrentWeather(currentWeather: CurrentWeatherResponse) async throws {
		currrentWeatherStorage.append(currentWeather)
	}
	
	func saveCurrentForecastWeather(forecastWeather: ForecastWeatherResponse) async throws {
		forecastWeatherStorage.append(forecastWeather)
	}
	
	func getCurrentWeatherWithCurrentLocation(completion: @escaping (Result<CurrentWeatherResponse, any Error>) -> Void) async throws {
		do {
			let response = try await weatherClient.fetchCurrentWeather(location: Location(lat: 0, lon: 0))
			completion(.success(response!))
		} catch {
			completion(.failure(error))
		}
	}
	
	func getForecastWeatherWithCurrentLocation(completion: @escaping (Result<WeatherIt.ForecastWeatherResponse, any Error>) -> Void) async throws {
		completion(.success(ForecastWeatherResponse(list: [ForecastDayDetails(dt_txt: "2025-01-22 21:00:00", main: WeatherDetails(temp: 15), weather: [WeatherDescription(main: .Rain)])])))
	}
	
	func checkIfInternetConnectionAvailable() -> Bool {
		return true
	}

}
