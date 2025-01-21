//
//  SeaTheme.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/20.
//
import Foundation
import SwiftUI

struct SeaTheme: ThemeProtocol {
	var sunnyImage: Image = Image("sea_sunny")
	var rainyImage: Image = Image("sea_rainy")
	var cloudyImage: Image = Image("sea_cloudy")
	
	var sunnyIconImage: Image = Image("ic-sunny")
	var rainyIconImage: Image = Image("ic-rainy")
	var cloudyIconImage: Image = Image("ic-cloudy")
	
	var sunnyThemeColor: Color = Color.seaSunny
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
	
	func getIcon(weather type: WeatherType) -> Image {
		switch type {
		case .Clear:
			return sunnyIconImage
		case .Rain:
			return rainyIconImage
		case .Clouds:
			return cloudyIconImage
		}
	}
}
