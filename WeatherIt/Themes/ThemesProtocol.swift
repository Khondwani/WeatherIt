//
//  ThemesProtocol.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/20.
//
import SwiftUI

protocol ThemeProtocol {
	var sunnyImage: Image { get }
	var rainyImage: Image { get }
	var cloudyImage: Image { get }
		
	var sunnyThemeColor: Color { get }
	var rainyThemeColor: Color { get }
	var cloudyThemeColor: Color { get }
	
	func getColor(weather type:WeatherType) -> Color
	func getImage(weather type:WeatherType) -> Image
	
}
