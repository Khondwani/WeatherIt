//
//  LocationService.swift
//  WeatherAppSwiftUI
//
//  Created by Khondwani Sikasote on 2025/01/20.
//

import Foundation
import CoreLocation

class LocationService: NSObject, LocationServiceProtocol {

	private let locationManager: CLLocationManager = CLLocationManager()
	// TODO: CONVERT THIS TO A OBSERVERABLE INSTEAD!
	private var currentLocation: Location?

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
	// TODO: SHOULD RETURN AN OBSERVER TO SUBSCRIBE TO!
	func getCurrentLocation() -> Location? {
		return currentLocation
	}
	
	func getAuthorizationStatus() -> CLAuthorizationStatus {
		return locationManager.authorizationStatus
	}

}

//MARK: ManagerDelagate Functionality
extension LocationService: CLLocationManagerDelegate {
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		switch  manager.authorizationStatus {
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
// TODO: CONVERT THIS TO A OBSERVERABLE INSTEAD!
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.last {
			let newLocation = Location(
				lat: location.coordinate.latitude,
				lon: location.coordinate.longitude)
			currentLocation = newLocation
		}
	}
}
