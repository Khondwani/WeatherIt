//
//  WeatherItView.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/18.
//

import SwiftUI

struct WeatherItView: View {
	@EnvironmentObject private var themeManager: ThemesManager
	@EnvironmentObject private var weatherItViewModule: WeatherItViewModule
	
	var body: some View {

		VStack {
			HeaderView(headerImage: themeManager.currentTheme.getImage(weather: weatherItViewModule.getCurrentWeatherType()), temp: weatherItViewModule.getCurrentTemp(), title: weatherItViewModule.getCurrentWeatherTitle())
			CurrentWeatherView(minTemp: weatherItViewModule.getCurrentWeatherMinTemp(), currentTemp: weatherItViewModule.getCurrentTemp(), maxTemp: weatherItViewModule.getCurrentWeatherMaxTemp())
			Divider().frame(height: 1).overlay(.white)
			ForecastListView(forecastList: weatherItViewModule.forecastWeather ?? [])
			
			
		}.background(themeManager.currentTheme.getColor(weather: weatherItViewModule.currentWeather?.weather[0].main ?? WeatherType.Clear)).ignoresSafeArea(.all).task {
			do {
				try await weatherItViewModule.getCurrentWeather()
				try await weatherItViewModule.getForecastWeather()

				print(weatherItViewModule.forecastWeather)
			} catch	{
				print(error)
			}
		}
	}

}

#Preview {
	var configuration = Configuration()
	
	WeatherItView().environmentObject(WeatherItViewModule(weatherClient: WeatherClient(baseUrl: configuration.environment.weatherBaseURL), locationService: LocationService())).environmentObject(ThemesManager())
}










