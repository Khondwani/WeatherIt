//
//  CurrentWeatherModel.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/19.
//

import Foundation

struct CurrentWeatherResponse: Codable { // changed it to codable so that i can encode it into my userDefaults
	let main: CurrentWeather
	let weather: [CurrentWeatherType]
}

struct CurrentWeather: Codable  {
	let temp: Double
	let temp_min: Double
	let temp_max: Double
}

struct CurrentWeatherType: Codable {
	let main: WeatherType // Rain, Clouds,
}

enum WeatherType: String, Codable { // we decode the Weather Type so that we use it
	case Rain
	case Clouds
	case Clear
}
