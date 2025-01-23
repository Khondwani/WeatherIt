//
//  LocationService.swift
//  WeatherAppSwiftUI
//
//  Created by Khondwani Sikasote on 2025/01/20.
//

import CoreLocation
import Foundation
import SwiftUI

class LocationService: NSObject, LocationServiceProtocol {
	
	private let locationManager: CLLocationManager = CLLocationManager()
	@Published var location: Location?  // we use it with the publisher (Combine)
	@Published var locationAuthorizationStatus: CLAuthorizationStatus?

	override init() {
		super.init()
		setupLocationServices()
	}

	func requestWhenInUseAuthorization() {
		locationManager.requestWhenInUseAuthorization()
	}

	func setupLocationServices() {
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.startUpdatingLocation()

		switch locationManager.authorizationStatus {
		case .notDetermined:
			requestWhenInUseAuthorization()
		case .authorizedAlways:
			break
		case .authorizedWhenInUse:
			break
		case .denied:
			requestWhenInUseAuthorization()
		default:
			break
		}
	}

	func getAuthorizationStatus() -> CLAuthorizationStatus {
		return locationManager.authorizationStatus
	}
	
	func getCurrentLocation() -> Location? {
		return location
	}

}

//MARK: ManagerDelagate Functionality
extension LocationService: CLLocationManagerDelegate {
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

		switch manager.authorizationStatus {
		case .notDetermined:
			requestWhenInUseAuthorization()
		case .authorizedAlways:
			locationAuthorizationStatus = .authorizedAlways
			break
		case .authorizedWhenInUse:
			locationAuthorizationStatus = .authorizedWhenInUse
			break
		case .denied:
			locationAuthorizationStatus = .denied
		default:
			break
		}
	}

	func locationManager(
		_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]
	) {
		if let location = locations.last {
			let newLocation = Location(
				lat: location.coordinate.latitude,
				lon: location.coordinate.longitude)
			self.location = newLocation
		}
	}
}
