//
//  WeatherRepositoryTest.swift
//  WeatherItTests
//
//  Created by Khondwani Sikasote on 2025/01/26.
//

import XCTest

@testable import WeatherIt

@MainActor
final class WeatherRepositoryTests: XCTestCase {
	var mockWeatherRepository: MockWeatherRepositoryImpl?
	var viewModel: WeatherItViewModel?
	override func setUp() {
		mockWeatherRepository = MockWeatherRepositoryImpl(
			weatherClient: MockWeatherClient(shouldReturnError: false))  // by default
		viewModel = WeatherItViewModel(
			weatherRepository: mockWeatherRepository!)
	}

	override func tearDown() {
		mockWeatherRepository = nil
		viewModel = nil
	}

	func
		testWeatherRepository_WhenCurrentWeatherForCurrenLocationRequestSucceeds_ShouldReturnCurrentWeatherObject()
		async throws
	{
		// Arrange
		let expectedCurrentWeatherObject: CurrentWeatherResponse =
			CurrentWeatherResponse(
				main: CurrentWeather(
					temp: 16.3, temp_min: 15.1, temp_max: 17.5),
				weather: [WeatherDescription(main: .Clear)])
		// Act

		try await viewModel?.weatherRepository
			.getCurrentWeatherWithCurrentLocation(completion: { result in
				switch result {
				// Assert
				case .success(let currentWeatherObject):
					XCTAssertEqual(
						currentWeatherObject.main.temp,
						expectedCurrentWeatherObject.main.temp,
						"The getCurrentWeatherWithCurrentLocation was called and returned an object with temperature value:\(currentWeatherObject.main.temp), but expecting: \(expectedCurrentWeatherObject.main.temp)"
					)
				case .failure:
						XCTFail("The getCurrentWeatherWithCurrentLocation was called and returned an error, but was expecting a current weather object: \(expectedCurrentWeatherObject)")
					break
				}
			})

	}

	func
		testWeatherRepository_WhenCurrentWeatherForCurrenLocationRequestFails_ShouldReturnAPIError()
		async throws
	{
		// Arrange
		mockWeatherRepository = MockWeatherRepositoryImpl(
			weatherClient: MockWeatherClient(shouldReturnError: true))  // by default
		viewModel = WeatherItViewModel(
			weatherRepository: mockWeatherRepository!)
		let expectedAPIError: APIError = APIError.invalidResponse
		// Act

		try await viewModel?.weatherRepository
			.getCurrentWeatherWithCurrentLocation(completion: { result in
				switch result {
				// Assert
				case .success(let currentWeather):
					XCTFail("The getCurrentWeatherWithCurrentLocation was called and returned: \(currentWeather), but was expecting an APIError")
					break
				case .failure(let error):
					XCTAssertEqual(
						error as! APIError, expectedAPIError,
						"The getCurrentWeatherWithCurrentLocation was called and returned the following error:\(error), but was expecting the following error: \(expectedAPIError)"
					)
					break
				}
			})

	}
}
