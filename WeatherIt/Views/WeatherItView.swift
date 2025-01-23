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
			
		}.alert("Important!", isPresented: $weatherItViewModule.isLocationNotAvailable, actions: {
			Button("Go To Settings", role: .cancel) {
				weatherItViewModule.openAppSettings()
			}
		},message: {
				Text("Location services are required to use this app. Please go to settings then click on Privacy > Location Services > WeatherIt and change the status to Allow")
		}).background(themeManager.currentTheme.getColor(weather: weatherItViewModule.getCurrentWeatherType() )).ignoresSafeArea(.all)
	}

}

#Preview {
	var configuration = Configuration()
	
	WeatherItView().environmentObject(WeatherItViewModule( weatherRepository: WeatherRepositoryImpl(weatherClient: WeatherClient(baseUrl: configuration.environment.weatherBaseURL), locationServices: LocationService()))).environmentObject(ThemesManager())
}










