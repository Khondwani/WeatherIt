//
//  ForecastListView.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/21.
//

import SwiftUI

struct ForecastListView: View {
	@EnvironmentObject private var themeManager: ThemesManager
	var forecastList: [ForecastDayDetails]
	
	var body: some View {
		List{
			ForEach(forecastList, id: \.dt_txt) { forecast in
				ForecastCellView(dayLeading: WeatherItViewModule.getDayFromDate(forecastDateAndTime: forecast.dt_txt), iconImage: themeManager.currentTheme.getIcon(weather: forecast.weather[0].main), tempTrailing: String(format: "%.f", forecast.main.temp))
			}
		}.listStyle(.plain).background(Color.clear)
	}
}
