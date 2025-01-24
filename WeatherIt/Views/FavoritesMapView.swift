//
//  FavoritesMapView.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/24.
//

import SwiftUI
import MapKit

struct FavoritesMapView: View {
	@State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -26.2056, longitude: 28.0337), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    var body: some View {
		Map(coordinateRegion: $region, showsUserLocation: true,  userTrackingMode: .constant(.followWithHeading)).ignoresSafeArea()
					
    }
}

#Preview {
    FavoritesMapView()
}
