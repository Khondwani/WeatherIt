//
//  WeatherItView.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/18.
//

import SwiftUI

struct WeatherItView: View {
	var weatherClient: WeatherClient = WeatherClient()
	var locationService: LocationService = LocationService()
	var body: some View {

		VStack {
			HeaderView(headerImage: "forest_sunny", temp: "25", title: "sunny")
			CurrentWeatherView(minTemp: "25", currentTemp: "25", maxTemp: "25")
			Divider().frame(height: 1).overlay(.white)
			ForecastView().border(Color.red)
			
			
		}.background(Color.sunny).ignoresSafeArea(.all).task {
			do {
//				let weather = try await weatherClient.fetchWeatherByCityName(for:"Chililabombwe")
				//Testing purposes
				let weather = try await weatherClient.fetchForecastWeather(location: locationService.getCurrentLocation()!)
				print(weather)
			} catch	{
				print(error)
			}
		}
	}

}

#Preview {
	WeatherItView()
}

struct HeaderView: View {
	var headerImage: String
	var temp: String
	var title: String
	var body: some View {
		ZStack {
			Image(headerImage, bundle: .main).resizable().aspectRatio(
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
