//
//  AppEnvironment.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/20.
//


import Foundation

enum AppEnvironment {
    case development
    case prod
	case test
    
    var weatherBaseURL: URL {
        switch self {
			case .development:
				return URL(string: "https://api.openweathermap.org/")!
			case .prod:
				return URL(string: "https://produrl")!
			case .test:
				return URL(string: "https://testurl")!
        }
    }
	
	var googlePlacesBaseURL: URL {
		switch self {
			case .development:
				return URL(string: "https://maps.googleapis.com")!
			case .prod:
				return URL(string: "https://maps.produrl")!
			case .test:
				return URL(string: "https://mpas.testurl")!
		}
	}
}

struct Configuration {
    lazy var environment: AppEnvironment = { // Only going to be set once
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return .development // deciding to use the development baseURLs for both google and weather
        }
        // We do this for testing purposes. So when we testing unit tests UI tests there is a key that is passed in ENV
        if env == "TEST" {
			return .test
        }
        return .development
    }()
}
