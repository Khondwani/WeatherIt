//
//  LocationServiceProtocol.swift
//  WeatherAppSwiftUI
//
//  Created by Khondwani Sikasote on 2025/01/20.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol {
	
	func setupLocationServices()
	func requestWhenInUseAuthorization()
	func getCurrentLocation() -> Location?
	func getAuthorizationStatus() -> CLAuthorizationStatus
	
}
