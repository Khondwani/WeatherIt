//
//  CurrentWeatherRepositoryImpl.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/22.
//

import Foundation
import CoreLocation
import Combine

enum LocationAuthorizationError: Error {
	case locationServicesDisabled
}

enum CacheUserDefaultError: Error {
	case unableToEncode
	case unableToDecode
	case unableToSave
	case unableToRetrieve
}

class WeatherRepositoryImpl: WeatherRepository {

	private let weatherClient: WeatherClient
	private let locationServices: LocationService
	private(set) var cancellables = Set<AnyCancellable>()
	private var userDefaults: UserDefaults = .standard
	private let encoder = JSONEncoder()
	private let decoder = JSONDecoder()
	
	var location: Published<Location?>.Publisher {
		locationServices.$location
	}
	
	var locationAuthorizationStatus: Published<CLAuthorizationStatus?>.Publisher {
		locationServices.$locationAuthorizationStatus
	}
	
	init(weatherClient: WeatherClient, locationServices: LocationService) {
		self.weatherClient = weatherClient
		self.locationServices = locationServices
	}
	
	func saveCurrentWeather(currentWeather: CurrentWeatherResponse) async throws {
		guard let offlineCurrentWeather = try? encoder.encode(currentWeather) else {
			throw CacheUserDefaultError.unableToEncode
		}
		userDefaults.set(offlineCurrentWeather, forKey: "currentWeather")
	}
	
	func saveCurrentForecastWeather(forecastWeather: ForecastWeatherResponse) async throws {
		guard let offlineCurrentForecastWeather = try? encoder.encode(forecastWeather) else {
			throw CacheUserDefaultError.unableToEncode
		}
		userDefaults.set(offlineCurrentForecastWeather, forKey: "currentForecastWeather")
	}
	
	func getCurrentWeatherWithCurrentLocation(completion: @escaping (Result<CurrentWeatherResponse, any Error>) -> Void) async throws {
			// we need to first check authoriaztion status
		
		self.locationAuthorizationStatus.sink { [weak self] status in
				if let status = status, status == .authorizedWhenInUse || status == .authorizedAlways {
					self?.location.sink { [weak self] location in
						if let location = location {
							Task {
								do {
									let currentWeather = try await self?.weatherClient.fetchCurrentWeather(
										location: location)
									
									try await self?.saveCurrentWeather(currentWeather: currentWeather!)
									
									completion(.success(currentWeather!))
								} catch {
									print("Error: \(error)")
									completion(.failure(error))
								}
							}
							
						}
					}.store(in: &self!.cancellables)
				}
				
				switch status {
					case .notDetermined:
						self?.locationServices.requestWhenInUseAuthorization()
					case .denied, .restricted:
						completion(.failure(LocationAuthorizationError.locationServicesDisabled))
					case .authorizedWhenInUse, .authorizedAlways:
						break
					default:
						break
				}
			}.store(in: &self.cancellables)
		
			
	}
	// NOTE: SINCE CURRENT WEATHER IS ALWAYS CALLED FIRST AND GETS THE LOCATION
	func getForecastWeatherWithCurrentLocation(completion: @escaping (Result<ForecastWeatherResponse, any Error>) -> Void) async throws {
		let location = self.locationServices.getCurrentLocation()
		Task {
			do {
				let forecastWeather = try await self.weatherClient.fetchForecastWeather(
					location: location)
				try await saveCurrentForecastWeather(forecastWeather: forecastWeather!)
				completion(.success(forecastWeather!))
			} catch {
				completion(.failure(error))
				
			}
		}
		
	}
	
	func getForecastWeatherWithCityName(_ cityName: String, completion: @escaping (Result<ForecastWeatherResponse, any Error>) -> Void) {
		
	}
	
	func getCurrentWeatherWithCityName(_ cityName: String, completion: @escaping (Result<CurrentWeatherResponse, any Error>) -> Void) {
		
	}
	
	private func checkIfInternetConnectionAvailable() -> Bool {
		return true
	}
}
