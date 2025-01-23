//
//  ForecastWeatherModel.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/19.
//

import Foundation

struct ForecastWeatherResponse: Codable {
	let list: [ForecastDayDetails]
}

struct ForecastDayDetails: Codable
{
	let dt_txt: String // USE THIS AS MY ID
	let main: WeatherDetails
	let weather: [WeatherDescription]
}

struct WeatherDetails: Codable {
	let temp: Double
}

struct WeatherDescription: Codable {
	let main: WeatherType
}
