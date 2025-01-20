//
//  WeatherClient.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/20.
//

import Foundation

enum APIError: Error {
	case invalidURL
	case invalidRequest
	case invalidResponse
	case decodingError
}

class WeatherClient {
	private var baseUrl: URL
	
	init(baseUrl: URL) {
		self.baseUrl = baseUrl
	}
	
	func fetchCurrentWeather(location: Location) async throws -> CurrentWeatherResponse? {
		guard let url = URL(string: APIEndpoints.currentWeatherByCoordinates(location.lat, location.lon).path, relativeTo: baseUrl) else {
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
	
	func fetchForecastWeather(location: Location) async throws -> ForecastWeatherResponse? {
		guard let url = URL(string: APIEndpoints.forecastWeatherByCoordinates(location.lat, location.lon).path, relativeTo: baseUrl) else {
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
