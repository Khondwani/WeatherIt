//
//  FavoritesMapView.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/24.
//

import MapKit
import SwiftUI

struct FavoritesMapView: View {
	@EnvironmentObject var favoritesViewModel: FavoritesViewModel

	@State private var region = MKCoordinateRegion(
		center: CLLocationCoordinate2D(latitude: -26.2056, longitude: 28.0337),
		span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

	var body: some View {
		Map {
			ForEach(favoritesViewModel.favoriteCitiesWeather, id: \.coord.lat) {
				cityWeather in
				Marker(
					cityWeather.name,
					image: favoritesViewModel.getMarkerIcon(
						weatherType: cityWeather.weather[0].main),
					coordinate: CLLocationCoordinate2D(
						latitude: cityWeather.coord.lat,
						longitude: cityWeather.coord.lon))
			}
		}.mapControls {
			MapPitchToggle()
			MapUserLocationButton()
			MapCompass()
		}
	}
}

#Preview {
	var configuration = Configuration()
	let locationSerice = LocationService()
	let internetMonitorService = InternetMonitorService()
	//Made it an environment object because It is a client that will be accesible on all screens.
	let weatherClient = WeatherClient(
		baseUrl: configuration.environment.weatherBaseURL)

	FavoritesMapView().environmentObject(
		FavoritesViewModel(
			favoriteWeatherRepository: FavoritesWeatherRepositoryImpl(
				weatherClient: weatherClient,
				internetMonitorService: internetMonitorService))
	)
}
