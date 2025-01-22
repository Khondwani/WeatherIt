//
//  CurrentWeatherView.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/21.
//

import SwiftUI

struct CurrentWeatherView: View {
	@EnvironmentObject private var weatherItViewModule: WeatherItViewModule


	
	var body: some View {
		HStack {
			CurrentWeatherDetailsView(temp: weatherItViewModule.getCurrentWeatherMinTemp(), title: "min").frame(maxWidth: .infinity, alignment: .leading)
			
			CurrentWeatherDetailsView(temp: weatherItViewModule.getCurrentTemp(), title: "Current")
			
			CurrentWeatherDetailsView(temp: weatherItViewModule.getCurrentWeatherMaxTemp(), title: "max").frame(maxWidth: .infinity, alignment: .trailing)
			
		}.padding(.horizontal ,16.0).padding(.top, 4)
	}
}
