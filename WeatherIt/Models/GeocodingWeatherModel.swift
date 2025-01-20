//
//  GeocodingWeatherModel.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/20.
//
import Foundation

// I will use this for the Weather Client I will have that will be used to add favourite locations
struct GeoCodingWeatherResponse: Decodable {
	let name: String
	let coord: Coordinates
	let weather: [WeatherDescription]
	let main: WeatherDetails
}

struct Coordinates: Decodable {
	let lon: Double
	let lat: Double
}
