//
//  CurrentWeatherDetailsView.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/21.
//

import SwiftUI

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
