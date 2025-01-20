//
//  ThemesManager.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/20.
//

import Foundation
class ThemesManager: ObservableObject {
	@Published var currentTheme: ThemeProtocol = ForestTheme()
	
	func setTheme(_ theme: ThemeProtocol) {
		currentTheme = theme
	}
}
