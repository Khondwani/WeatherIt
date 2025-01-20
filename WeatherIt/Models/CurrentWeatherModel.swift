//
//  CurrentWeatherModel.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/19.
//

import Foundation

struct CurrentWeatherResponse: Decodable {
	let main: CurrentWeather
	let weather: [CurrentWeatherType]
}

struct CurrentWeather: Decodable  {
	let temp: Double
	let temp_min: Double
	let temp_max: Double
}

struct CurrentWeatherType: Decodable {
	let main: WeatherType // Rain, Clouds,
}

enum WeatherType: String, Decodable { // we decode the Weather Type so that we use it
	case Rain
	case Clouds
	case Clear
}
