//
//  GeocodingWeatherModel.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/20.
//
import Foundation

// I will use this for the Weather Client I will have that will be used to add favourite locations by search by City
typealias City = GeoCodingWeatherResponse

struct GeoCodingWeatherResponse: Codable {
	let name: String
	let coord: Location
	let weather: [WeatherDescription]
	let main: CurrentWeather
}
