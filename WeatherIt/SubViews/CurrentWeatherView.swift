//
//  CurrentWeatherView.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/21.
//

import SwiftUI

struct CurrentWeatherView: View {
	@EnvironmentObject private var WeatherItViewModel: WeatherItViewModel
	var body: some View {
		HStack {
			CurrentWeatherDetailsView(temp: WeatherItViewModel.getCurrentWeatherMinTemp(), title: "min").frame(maxWidth: .infinity, alignment: .leading)
			
			CurrentWeatherDetailsView(temp: WeatherItViewModel.getCurrentTemp(), title: "Current")
			
			CurrentWeatherDetailsView(temp: WeatherItViewModel.getCurrentWeatherMaxTemp(), title: "max").frame(maxWidth: .infinity, alignment: .trailing)
			
		}.padding(.horizontal ,16.0)
	}
}

#Preview {
	var configuration = Configuration()
	WeatherItView().environmentObject(
		WeatherItViewModel(
			weatherRepository: WeatherRepositoryImpl(weatherClient: WeatherClient(baseUrl: configuration.environment.weatherBaseURL), locationServices: LocationService(), internetMonitorService: InternetMonitorService()))
	).environmentObject(ThemesManager())
}
