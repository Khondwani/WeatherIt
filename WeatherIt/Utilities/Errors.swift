//
//  Errors.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/26.
//
import Foundation

enum APIError: Error {
	case invalidURL
	case invalidRequest
	case invalidResponse
	case decodingError
}

enum InternetAvailabilityError: Error {
	case internetUnavailable
}

enum PersistenceError: Error {
	case itemNotFound
}

enum LocationAuthorizationError: Error {
	case locationServicesDisabled
}

enum CacheUserDefaultError: Error {
	case unableToEncode
	case unableToDecode
	case unableToSave
	case unableToRetrieve
}
