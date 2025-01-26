//
//  FloatingActionButton.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/23.
//
import Foundation
import SwiftUI

enum NavigationPaths: String, CaseIterable, Hashable {
	case Favorites
	case Map
}
struct FloatingActionButton: View {
	@Binding var isExpanded: Bool
	var body: some View {
		VStack {
			if isExpanded {
				NavigationLink(value: NavigationPaths.Favorites) {
					// WHAT THE LINK LOOKS LIKE
					Image(systemName: "cloud.sun.fill").font(.title2).padding()
						.foregroundColor(.black).background(Color.white)
						.clipShape(.circle)
				}

				NavigationLink(value: NavigationPaths.Map) {
					// WHAT THE LINK LOOKS LIKE
					Image(systemName: "map.fill").font(.title2).padding()
						.foregroundColor(.black).background(Color.white)
						.clipShape(.circle)
				}

			}
			Button(
				action: {
					// we expanded the button
					self.isExpanded.toggle()
				},
				label: {

					Image(
						systemName: isExpanded
							? "list.bullet.indent" : "list.bullet"
					).font(.title).padding().foregroundColor(.white)
						.background(
							Color.black
						).clipShape(.circle)

				}
			).padding(.horizontal, 16).padding(.bottom, 16).shadow(
				color: .white, radius: 2)

		}.navigationDestination(for: NavigationPaths.self) { paths in
			switch paths {
			case .Favorites:
				FavoritesView()
			case .Map:
				FavoritesMapView()
			}

		}.onDisappear {
			isExpanded = false
		}
	}
}

#Preview {
	@Previewable @State var isExpanded: Bool = false
	NavigationStack {
		FloatingActionButton(isExpanded: $isExpanded)
	}
}
