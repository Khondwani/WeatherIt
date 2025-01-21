//
//  CurrentWeatherView.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/21.
//

import SwiftUI

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
