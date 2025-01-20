//
//  ForestTheme.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/20.
//
import Foundation
import SwiftUI

struct ForestTheme: ThemeProtocol {
	
	var sunnyImage: Image = Image("forest_sunny")
	var rainyImage: Image = Image("forest_rainy")
	var cloudyImage: Image = Image("forest_cloudy")
	
	var sunnyThemeColor: Color = Color.sunny
	var rainyThemeColor: Color = Color.rainy
	var cloudyThemeColor: Color = Color.cloudy
	
	func getColor(weather type: WeatherType) -> Color {
		switch type {
			case .Clear:
				return sunnyThemeColor
			case .Rain:
				return rainyThemeColor
			case .Clouds:
				return cloudyThemeColor
		}
	}
	
	func getImage(weather type: WeatherType) -> Image {
		switch type {
			case .Clear:
				return sunnyImage
			case .Rain:
				return rainyImage
			case .Clouds:
				return cloudyImage
		}
	}
}

