//
//  FavoritesWeatherRepository.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/24.
//
import Foundation

protocol FavoritesWeatherRepository {

	func saveFavoriteWeather(favoriteWeather: GeoCodingWeatherResponse) async throws
		// NOTE: WE GET FROM LOCAL STORAGE
	func getFavoriteWeatherList() async throws -> [GeoCodingWeatherResponse]
	
	func getCurrentWeatherWithCityName(_ cityName: String, completion: @escaping (Result<GeoCodingWeatherResponse, Error>) -> Void)
	
	func getCurrentWeatherWithLocation(_ cityName: String, _ location: Location, completion: @escaping (Result<CurrentWeatherResponse, Error>) -> Void)
	
	func updateFavoriteWeather(cityName: String,favoriteWeather: CurrentWeatherResponse) async throws
	
	func checkIfInternetConnectionAvailable() -> Bool
		
}
