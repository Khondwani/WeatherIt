//
//  WeatherItView.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/18.
//

import SwiftUI

struct WeatherItView: View {
	@EnvironmentObject private var themeManager: ThemesManager
	@EnvironmentObject private var weatherItViewModel: WeatherItViewModel
	@State var isExpanded: Bool = false
	
	var body: some View {
		
		VStack {
			HeaderView()
			CurrentWeatherView()
			Divider().frame(height: 1).overlay(.white)
			ForecastListView()
			
		}.overlay(alignment: .center){
			if weatherItViewModel.isLoadingForecastWeather && weatherItViewModel.isLoadingCurrentWeather {
				ProgressView().tint(.white).controlSize(.large)
			}
		}.alert("Important!", isPresented: $weatherItViewModel.isLocationNotAvailable, actions: {
			Button("Go To Settings", role: .cancel) {
				weatherItViewModel.openAppSettings()
			}
		},message: {
				Text("Location services are required to use this app. Please go to settings then click on Privacy > Location Services > WeatherIt and change the status to Allow")
		}).background(themeManager.currentTheme.getColor(weather: weatherItViewModel.getCurrentWeatherType() )).ignoresSafeArea(.all).overlay(alignment: .bottomTrailing) {
			FloatingActionButton(isExpanded: $isExpanded)

		}
	}

}

#Preview {
	var configuration = Configuration()
	NavigationStack{
		WeatherItView().environmentObject(WeatherItViewModel( weatherRepository: WeatherRepositoryImpl(weatherClient: WeatherClient(baseUrl: configuration.environment.weatherBaseURL), locationServices: LocationService(), internetMonitorService: InternetMonitorService()))).environmentObject(ThemesManager())
	}
}

