//
//  constants.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/20.
//

import Foundation

struct Constants {
	struct Keys {
		static let weatherAPIKey = Bundle.main.infoDictionary?["WEATHER_API_KEY"] as? String ?? ""
	}
}
