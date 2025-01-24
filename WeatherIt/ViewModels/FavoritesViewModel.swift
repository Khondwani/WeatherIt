//
//  FavoritesViewModel.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/23.
//

import Foundation
@MainActor
class FavoritesViewModel: ObservableObject {
	@Published var searchedCityWeather: City? = nil // List Of Cities that have been marked as favorite.
	@Published var showSearchedCityWeather: Bool = false
	@Published var favoriteCitiesWeather: [City] = []
	
	@Published var isLoading: Bool = false
	
	private let favoriteWeatherRepository: FavoritesWeatherRepository
	
	init( favoriteWeatherRepository: FavoritesWeatherRepository) {
		self.favoriteWeatherRepository = favoriteWeatherRepository
		self.getFavoriteCitiesWeather()
	}
	
	
	func searchWeatherForCityName(cityName: String) {
		isLoading = true
		favoriteWeatherRepository.getCurrentWeatherWithCityName(cityName) { [weak self] result in
			switch result {
				case .success(let weatherData):
					print("Weather Data: \(weatherData)")
					DispatchQueue.main.async {
						self?.searchedCityWeather = weatherData
						self?.showSearchedCityWeather.toggle()
						self?.isLoading = false
					}
				case .failure(let error):
					DispatchQueue.main.async {
						self?.isLoading = false
					}
					print("Error: \(error)")
			}
		}
	}
	func addToFavorites(city: City) {
		if !checkIfCityExists(city: city) {
			isLoading = true
			Task {
				do {
					try await favoriteWeatherRepository.saveFavoriteWeather(favoriteWeather: city)
					self.getFavoriteCitiesWeather()
					self.showSearchedCityWeather = false // close the modal
					self.searchedCityWeather = nil 
					self.isLoading = false
				} catch {
					self.isLoading = false
					print(error)
				}
				
			}
		} else {
			self.showSearchedCityWeather = false // close the modal
			self.searchedCityWeather = nil
			self.isLoading = false
		}
		
	}
	
	func checkIfCityExists(city: City) -> Bool {
		favoriteCitiesWeather.contains(where: { $0.name == city.name })
	}
	
	func getFavoriteCitiesWeather()  {
		
		Task {
			do {
				favoriteCitiesWeather = try await favoriteWeatherRepository.getFavoriteWeatherList()
				self.isLoading = false
			}
			catch {
				self.isLoading = false
				print(error)
			}
		}
	}
	
	func getSavedFavoritesWeatherWithCoords(for cityName: String ,with location: Location) {
		self.isLoading = true
		favoriteWeatherRepository.getCurrentWeatherWithLocation(cityName, location) { results in
			switch results {
				case .success(_):
					DispatchQueue.main.async {
						self.getFavoriteCitiesWeather()
						self.isLoading = false
					}
				case .failure(let error):
					self.isLoading = false
					print(error)
			}
		}
	}
	
	func getSearchedCityTemp() -> String {
		guard let searchedCityWeather = searchedCityWeather else {
			return "-"
		}
		return "\(Int(searchedCityWeather.main.temp))"  // no decimals
	}

	func getSearchedCityWeatherType() -> WeatherType {
		guard let searchedCityWeather = searchedCityWeather else {
			return .Clear
		}
		return searchedCityWeather.weather[0].main
	}

	func getSearchedCityWeatherTitle() -> String {
		guard let searchedCityWeather = searchedCityWeather else {
			return "-"
		}
		switch searchedCityWeather.weather[0].main {
		case .Clear:
			return "sunny"
		case .Clouds:
			return "cloudy"
		case .Rain:
			return "rainy"
		}
	}
	
	func getFavoritesCityWeatherTitle(weatherType: WeatherType) -> String {
		switch weatherType {
		case .Clear:
			return "Sunny"
		case .Clouds:
			return "Cloudy"
		case .Rain:
			return "Rainy"
		}
	}
	
	func getSearchedCityWeatherMinTemp() -> String {
		guard let searchedCityWeather = searchedCityWeather else {
			return "-"
		}
		return "\(Int(searchedCityWeather.main.temp_min))"
	}

	func getSearchedCityWeatherMaxTemp() -> String {
		guard let searchedCityWeather = searchedCityWeather else {
			return "-"
		}
		return "\(Int(searchedCityWeather.main.temp_max))"
	}

	
}
