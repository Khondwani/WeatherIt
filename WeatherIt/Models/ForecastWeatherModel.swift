//
//  ForecastWeatherModel.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/19.
//

import Foundation

struct ForecastWeatherResponse: Decodable {
	let list: [ForecastDayDetails]
}

struct ForecastDayDetails: Decodable {
	let dt_txt: String
	let main: WeatherDetails
	let weather: [WeatherDescription]
}

struct WeatherDetails: Decodable {
	let temp: Double
}

struct WeatherDescription: Decodable {
	let main: WeatherType
}
