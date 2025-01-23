//
//  WeatherItViewModule.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/20.
//

import Foundation
import Combine
import CoreLocation
import SwiftUI

@MainActor
class WeatherItViewModule: ObservableObject {
	@Published private(set) var currentWeather: CurrentWeatherResponse? = nil
	@Published private(set) var forecastWeather: [ForecastDayDetails]? = []
	@Published var isLocationNotAvailable: Bool = false // by default
	
	private let weatherRepository: WeatherRepository
	
	init( weatherRepository: WeatherRepository) {
		self.weatherRepository = weatherRepository
		getCurrentWeatherWithForecastWeather()
	}
	
	// business logic
	func getCurrentWeatherWithForecastWeather() {
		Task {
			do {
				try await weatherRepository.getCurrentWeatherWithCurrentLocation { [weak self] result in
					   switch result {
						   case .success(let currentWeather):
							   DispatchQueue.main.async {
								   self?.isLocationNotAvailable = false
								   self?.currentWeather = currentWeather
								   self?.getForecastWeather()
							   }
						   case .failure(let error):
							   if error.self  is LocationAuthorizationError {
								   DispatchQueue.main.async {
									   self?.isLocationNotAvailable = true
								   }
							   }
					   }
			   }
			} catch
				{
				print(error)
			}
		}
	}

	func getForecastWeather() {
		Task {
			do {
				try await weatherRepository.getForecastWeatherWithCurrentLocation { [weak self] result in
					switch result {
						case .success(let forecastWeather):
							DispatchQueue.main.async {
									// We only get the next 5 dates after current date. We also consider the time,
									// So if its 12:30 we get the time 12:00:00, if its 13:00:00 we also get 12:00:00
									let date = Date()
									
								let filteredForecastWeatherList = self?.removeTodaysForecastWeather(
										list: forecastWeather.list,
										today: DateFormatter.stringYYYYMMddDash(from: date))

									
									let timeString = DateFormatter.stringHHmmssColon(from: date)//timeDateFormatter.string(from: date)

								self?.forecastWeather = self?.getForecastWeatherListBasedOnTime(
									list: filteredForecastWeatherList!, currentTime: timeString)
							}
						case .failure(let error):
							print("Error: \(error)")
					}
				}
			} catch {
				print(error)
			}
		}
		
		
	}

	private func removeTodaysForecastWeather(
		list forecastWeatherList: [ForecastDayDetails], today date: String
	) -> [ForecastDayDetails] {
		return forecastWeatherList.filter {
			return !$0.dt_txt.contains(date)
		}
	}

	private func getForecastWeatherListBasedOnTime(
		list forecastWeatherList: [ForecastDayDetails], currentTime: String
	) -> [ForecastDayDetails] {
		return forecastWeatherList.filter {
			// we get the date then we backtrack to the nearest 3hrs interval
			/*
			  interval 1 => 00:00:00
			  interval 2 => 03:00:00
			  interval 3 => 06:00:00
			  interval 4 => 09:00:00
			  interval 5 => 12:00:00
			  interval 6 => 15:00:00
			  interval 7 => 18:00:00
			  interval 8 => 21:00:00

			  left and right interval find it then ge the correct forecast time

			 So we have 13:30:00 as my time so 13/3 = lower bound 4.3 upper bound 5.3 (4,5) => (12,15)
			  22:00:00 => lower bound 22/3 => 7.3 upper bound 8.3 (7,8) => (21,00)

			  */

			let nowHours = Int(currentTime.split(separator: ":").first!)!
			let lowerbound = Int(nowHours / 3)
			let upperbound = lowerbound + 1
			let lowerTimeInterval = lowerbound * 3
			let upperTimeInterval = upperbound * 3

			if nowHours >= lowerTimeInterval && nowHours < upperTimeInterval {
				return $0.dt_txt.contains("\(lowerTimeInterval):00:00")
			} else {
				return $0.dt_txt.contains("\(upperTimeInterval):00:00")
			}
		}
	}

	static func getDayFromDate(forecastDateAndTime: String) -> String {
		let forecastDate = String(forecastDateAndTime.split(separator: " ").first!)
		return DateFormatter.stringDayOnly(from: DateFormatter.stringDateToDate(from: forecastDate)!)
	}

	func getCurrentTemp() -> String {
		guard let currentWeather = currentWeather else {
			return "-"
		}
		return String(format: "%.f", currentWeather.main.temp)  // no decimals
	}

	func getCurrentWeatherType() -> WeatherType {
		guard let currentWeather = currentWeather else {
			return .Clear
		}
		return currentWeather.weather[0].main
	}

	func getCurrentWeatherTitle() -> String {
		guard let currentWeather = currentWeather else {
			return "-"
		}
		switch currentWeather.weather[0].main {
		case .Clear:
			return "sunny"
		case .Clouds:
			return "cloudy"
		case .Rain:
			return "rainy"
		}
	}

	func getCurrentWeatherMinTemp() -> String {
		guard let currentWeather = currentWeather else {
			return "-"
		}
		return String(format: "%.f", currentWeather.main.temp_min)
	}

	func getCurrentWeatherMaxTemp() -> String {
		guard let currentWeather = currentWeather else {
			return "-"
		}
		return String(format: "%.f", currentWeather.main.temp_max)
	}
	
	func openAppSettings() {
		// Works well on a physical device simulators xcode bug openning blank screen
		if let url = URL(string: UIApplication.openSettingsURLString) {
			UIApplication.shared.open(url)
		}
	}
	
}


