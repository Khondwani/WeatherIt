//
//  FavoritesWeatherRepositoryImpl.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/24.
//

import Foundation
import SwiftUI

class FavoritesWeatherRepositoryImpl: FavoritesWeatherRepository {
	
	private let weatherClient: WeatherClient
	private let internetMonitorService: InternetMonitorService
	private var userDefaults: UserDefaults = .standard
	private let encoder = JSONEncoder()
	private let decoder = JSONDecoder()
	
	init(weatherClient: WeatherClient, internetMonitorService: InternetMonitorService) {
		self.weatherClient = weatherClient
		self.internetMonitorService = internetMonitorService
	}

	
	func saveFavoriteWeather(favoriteWeather: GeoCodingWeatherResponse) async throws {
		var favoritesWeatherList = try await getFavoriteWeatherList()
		favoritesWeatherList.append(favoriteWeather)
		guard let newFavoriteWeatherList = try? encoder.encode(favoritesWeatherList)
		else {
			throw CacheUserDefaultError.unableToEncode
		}
		userDefaults.set(newFavoriteWeatherList, forKey: "favoritesWeatherList")
	}
	
	func getFavoriteWeatherList() async throws -> [GeoCodingWeatherResponse] {
		let favoritesWeatherList = userDefaults.object(
				forKey: "favoritesWeatherList")
		
		if favoritesWeatherList != nil {
			guard
				let favorites = try? decoder.decode(
					[GeoCodingWeatherResponse].self, from: favoritesWeatherList as! Data)
			else {
				throw CacheUserDefaultError.unableToDecode
			}
			return favorites
		} else {
			return [] //an Empty array to add to!
		}

	}
	
	func getCurrentWeatherWithCityName(_ cityName: String, completion: @escaping (Result<GeoCodingWeatherResponse, any Error>) -> Void) {
		if checkIfInternetConnectionAvailable() {
			Task {
				do {
					let cityWeather = try await self.weatherClient.fetchWeatherByCityName(for: cityName)
					completion(.success(cityWeather!))
				} catch {
					completion(.failure(error))
				}
			}
		} else {
			completion(.failure(InternetAvailabilityError.internetUnavailable))
		}
	}
	
	func getCurrentWeatherWithLocation(_ cityName: String, _ location: Location, completion: @escaping (Result<CurrentWeatherResponse, any Error>) -> Void) {
		Task {
			do {
				let currentFavoriteCityWeather = try await self
					.weatherClient.fetchCurrentWeather(location: location)
				
				try await updateFavoriteWeather(cityName: cityName,favoriteWeather: currentFavoriteCityWeather!)
				
			} catch {
				
			}
		}
	}
	
	func updateFavoriteWeather(cityName: String,favoriteWeather: CurrentWeatherResponse) async throws {
		// first we get the favoritesList, then get the old one that was saved
		var currentFavoriteWeatherList = try await getFavoriteWeatherList()
		let index = findWeatherIndex(in: currentFavoriteWeatherList,of: cityName)
		
		guard let foundIndex = index else {
			throw PersistenceError.itemNotFound
		}
		
		let updatedFavoriteWeather: GeoCodingWeatherResponse = .init(
			name: currentFavoriteWeatherList[foundIndex].name,
			coord: currentFavoriteWeatherList[foundIndex].coord,
			weather: favoriteWeather.weather, main: favoriteWeather.main)
		
		currentFavoriteWeatherList[foundIndex] = updatedFavoriteWeather
		guard let newFavoriteWeatherList = try? encoder.encode(currentFavoriteWeatherList)
		else {
			throw CacheUserDefaultError.unableToEncode
		}
		userDefaults.set(newFavoriteWeatherList, forKey: "favoritesWeatherList")
	}
	
	private func findWeatherIndex(in favoriteWeathers: [GeoCodingWeatherResponse], of cityName: String) -> Int? {
		return favoriteWeathers.firstIndex { favoriteWeather in
			favoriteWeather.name == cityName // with the same name get that index
		}
	}
	
	func checkIfInternetConnectionAvailable() -> Bool {
		return internetMonitorService.getInternetAvailability()
	}
	

	
}
