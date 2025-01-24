//
//  ForecastListView.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/21.
//

import SwiftUI

struct ForecastListView: View {
	@EnvironmentObject private var themeManager: ThemesManager
	@EnvironmentObject private var weatherItViewModel: WeatherItViewModel
	
	var body: some View {
		List{
			ForEach(weatherItViewModel.forecastWeather ?? [], id: \.dt_txt) { forecast in
				ForecastCellView(dayLeading: WeatherItViewModel.getDayFromDate(forecastDateAndTime: forecast.dt_txt), iconImage: themeManager.currentTheme.getIcon(weather: forecast.weather[0].main), tempTrailing: "\(Int(forecast.main.temp))")
			}
		}.listStyle(.plain).background(Color.clear)
	}
}
