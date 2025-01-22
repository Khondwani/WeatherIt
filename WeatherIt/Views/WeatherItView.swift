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
			HeaderView()
			CurrentWeatherView()
			Divider().frame(height: 1).overlay(.white)
			ForecastListView()
			
			
		}.background(themeManager.currentTheme.getColor(weather: weatherItViewModule.getCurrentWeatherType() )).ignoresSafeArea(.all).task {
			do {
				
				try await weatherItViewModule.getCurrentWeather()
				try await weatherItViewModule.getForecastWeather()

				
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










