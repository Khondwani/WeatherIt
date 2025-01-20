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
			ForecastView()
			
			
		}.background(themeManager.currentTheme.getColor(weather: weatherItViewModule.currentWeather?.weather[0].main ?? WeatherType.Clear)).ignoresSafeArea(.all).task {
			do {
				try await weatherItViewModule.getCurrentWeather()
				print(weatherItViewModule.currentWeather)
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

struct HeaderView: View {
	var headerImage: Image
	var temp: String
	var title: String
	var body: some View {
		ZStack {
			headerImage.resizable().aspectRatio(
				contentMode: .fit
			)
			VStack(alignment: .center) {
				Text("\(temp)°").font(.system(size: 60)).foregroundColor(.white)
				Text(title.uppercased()).font(.system(size: 30)).tracking(2).fontWeight(.medium).foregroundColor(.white)
				Spacer()
					.frame(height: 60)
				
			}
		}
	}
}

struct CurrentWeatherView: View {
	var minTemp: String
	var currentTemp: String
	var maxTemp: String
	
	var body: some View {
		HStack {
			CurrentWeatherDetailsView(temp: minTemp, title: "min").frame(maxWidth: .infinity, alignment: .leading)
			
			CurrentWeatherDetailsView(temp: currentTemp, title: "Current")
			
			CurrentWeatherDetailsView(temp: maxTemp, title: "max").frame(maxWidth: .infinity, alignment: .trailing)
			
		}.padding(.horizontal ,16.0).padding(.top, 4)
	}
}

struct CurrentWeatherDetailsView: View {
	var temp: String
	var title: String
	var body: some View {
		VStack(alignment: .center) {
			Text("\(temp)°").font(.system(size: 18)).fontWeight(.medium).foregroundColor(.white)
			Text(title).font(.system(size: 18)).fontWeight(.light).foregroundColor(.white)
			
		}
	}
}

struct ForecastCellView: View {
	var dayLeading: String
	var icon: String
	var tempTrailing: String
	var body: some View {
		HStack {
			Text(dayLeading).foregroundStyle(.white).font(.system(size: 18)).frame(maxWidth: .infinity, alignment: .leading)
			
			Image(icon).resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center)
			
			Text("\(tempTrailing)°").foregroundStyle(.white).font(.system(size: 18)).fontWeight(.medium).frame(maxWidth: .infinity, alignment: .trailing)
		}.background(Color.clear).listRowBackground(Color.clear).listRowSeparator(.hidden).listRowInsets(.none)
	}
}

struct ForecastView: View {
	var body: some View {
		List {
			ForecastCellView(dayLeading: "Monday", icon: "ic-sunny", tempTrailing: "25")
		}.listStyle(.plain).background(Color.clear)
	}
}
