//
//  APIEndpoints.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/20.
//

import Foundation

enum APIEndpoints {

	case currentWeatherByCoordinates(Double, Double)
	case forecastWeatherByCoordinates(Double, Double)
	// We can also setup the other endpoints I will use for favorites feature
	case weatherByCityName(String)

	var path: String {
		switch self {
			case .currentWeatherByCoordinates(let lat, let lon):
				return "/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=\(Constants.Keys.weatherAPIKey)"
			case .forecastWeatherByCoordinates(let lat, let lon):
				return "/data/2.5/forecast?lat=\(lat)&lon=\(lon)&units=metric&appid=\(Constants.Keys.weatherAPIKey)"
			case .weatherByCityName(let cityName):
				return "/data/2.5/weather?q=\(cityName)&units=metric&appid=\(Constants.Keys.weatherAPIKey)"
				
		}
	}

}
