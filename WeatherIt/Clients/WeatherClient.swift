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

struct WeatherClient {
	func fetchCurrentWeather(location: Location) async throws -> CurrentWeatherResponse? {
		let (data,response) = try await URLSession.shared.data(from: APIManager.endPointURL(for: .currentWeatherByCoordinates(location.lat, location.lon)))
		
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
		let (data,response) = try await URLSession.shared.data(from: APIManager.endPointURL(for: .forecastWeatherByCoordinates(location.lat, location.lon)))
		
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
		let (data,response) = try await URLSession.shared.data(from: APIManager.endPointURL(for: .weatherByCityName(cityName)))
		
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
