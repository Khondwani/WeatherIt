//
//  WeatherClient.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/20.
//

import Foundation



class WeatherClient: WeatherClientProtocol {
	private var baseUrl: URL
	
	init(baseUrl: URL) {
		self.baseUrl = baseUrl
	}
	
	func fetchCurrentWeather(location: Location?) async throws -> CurrentWeatherResponse? {
		guard let url = URL(string: APIEndpoints.currentWeatherByCoordinates(location?.lat ?? 0, location?.lon ?? 0).path, relativeTo: baseUrl) else {
			throw APIError.invalidURL
		}
		
		let (data,response) = try await URLSession.shared.data(from: url)
		
		guard let response = response as? HTTPURLResponse else {
			throw APIError.invalidRequest
		}
		
		guard response.statusCode == 200 else {
			throw APIError.invalidResponse
		}
		
		
		guard let weather = try? JSONDecoder().decode(CurrentWeatherResponse.self, from: data) else {
			throw APIError.decodingError
		}
		return weather
	}
	
	func fetchForecastWeather(location: Location?) async throws -> ForecastWeatherResponse? {
		guard let url = URL(string: APIEndpoints.forecastWeatherByCoordinates(location?.lat ?? 0, location?.lon ?? 0).path, relativeTo: baseUrl) else {
			throw APIError.invalidURL
		}
		
		let (data,response) = try await URLSession.shared.data(from: url)
		
		guard let response = response as? HTTPURLResponse else {
			throw APIError.invalidRequest
		}
		
		guard response.statusCode == 200 else {
			throw APIError.invalidResponse
		}
		
		
		guard let weather = try? JSONDecoder().decode(ForecastWeatherResponse.self, from: data) else {
			throw APIError.decodingError
		}
		return weather
	}
	
	func fetchWeatherByCityName(for cityName: String) async throws -> GeoCodingWeatherResponse? {
		guard let url = URL(string: APIEndpoints.weatherByCityName(cityName).path, relativeTo: baseUrl) else {
			throw APIError.invalidURL
		}
		
		let (data,response) = try await URLSession.shared.data(from: url)
		
		guard let response = response as? HTTPURLResponse else {
			throw APIError.invalidRequest
		}
		
		guard response.statusCode == 200 else {
			throw APIError.invalidResponse
		}
		
		guard let weather = try? JSONDecoder().decode(GeoCodingWeatherResponse.self, from: data) else {
			throw APIError.decodingError
		}
		return weather
	}
}
