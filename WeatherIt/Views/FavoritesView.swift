//
//  FavoritesView.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/23.
//

import Foundation
import SwiftUI

struct FavoritesView: View {
	@State private var searchText = ""
	@EnvironmentObject var favoritesViewModel: FavoritesViewModel
	@EnvironmentObject var themeManager: ThemesManager
	@State private var isAddCityToFavoritesClicked: Bool = false

	
	//Taking a book out of apples weather app
	var body: some View {
		ScrollView {
			VStack(spacing: 16) {
				ForEach(
					favoritesViewModel.favoriteCitiesWeather, id: \.coord.lat
				) { city in
					if favoritesViewModel.isLoading {
						HStack {
							Spacer()
							ProgressView()
							Spacer()
						}
					} else {
						VStack(alignment: .leading) {
							HStack {
								Text(city.name).font(.title).padding(.bottom, 4)
								Spacer()
								Text("\(Int(city.main.temp))°C").font(.title)
							}
							HStack {
								VStack {
									Text(
										favoritesViewModel
											.getFavoritesCityWeatherTitle(
												weatherType: city.weather[0]
													.main))
								}
								Spacer()
								Text("H:\(Int(city.main.temp_max))")
								Text("L:\(Int(city.main.temp_min))")
							}
						}.padding()
					}

				}.frame(
					maxWidth: .infinity, minHeight: 100, alignment: .topLeading
				).background(.white).cornerRadius(20).padding(.horizontal, 16)
					.shadow(color: Color.black.opacity(0.2), radius: 4)
			}.onAppear {
				// let us get currentWeather always
				for favoriteCity in favoritesViewModel.favoriteCitiesWeather {

					favoritesViewModel.getSavedFavoritesWeatherWithCoords(
						for: favoriteCity.name,
						with: Location(
							lat: favoriteCity.coord.lat,
							lon: favoriteCity.coord.lon))
				}
				// then we call the function to update the view
				favoritesViewModel.getFavoriteCitiesWeather()
				// Using it just to make sure my Published values have been sent out.
				favoritesViewModel.objectWillChange.send()
			}

		}.emptyListView($favoritesViewModel.favoriteCitiesWeather) {
			Text(
				"You currently have no favorites. Search for a city or town to add to your favorites!"
			)  // Placeholder
			.font(.footnote).multilineTextAlignment(.center).padding(.all, 16)
		}.navigationBarTitle("Weather", displayMode: .large).searchable(
			text: $searchText,
			placement: .navigationBarDrawer(displayMode: .always),
			prompt: "Search for City or Town"
		)
		.onSubmit(of: .search, search).sheet(
			isPresented: $favoritesViewModel.showSearchedCityWeather
		) {

			VStack {
				ZStack(alignment: .top) {
					themeManager.currentTheme.getImage(
						weather: favoritesViewModel.getSearchedCityWeatherType()
					).resizable().aspectRatio(
						contentMode: .fit
					)
					VStack {
						Text("\(favoritesViewModel.searchedCityWeather!.name) ")
							.font(.system(size: 40)).fontWeight(.regular)
							.foregroundStyle(.white)
						Text("\(favoritesViewModel.getSearchedCityTemp())°")
							.font(
								.system(size: 60)
							).foregroundColor(.white)
						Text(
							favoritesViewModel.getSearchedCityWeatherTitle()
								.uppercased()
						)
						.font(.system(size: 18)).tracking(2)
						.fontWeight(.medium).foregroundColor(
							.white.opacity(0.8))
						HStack {
							Text(
								"H: \(favoritesViewModel.getSearchedCityWeatherMaxTemp())°"
							).font(.system(size: 25))
								.fontWeight(.medium).foregroundColor(.white)
							Spacer().frame(width: 16)
							Text(
								"L:\(favoritesViewModel.getSearchedCityWeatherMinTemp())°"
							).font(.system(size: 25))
								.fontWeight(.medium).foregroundColor(.white)
						}
					}.padding(.top, 30)

				}
				Spacer()
				Button(
					action: {
						isAddCityToFavoritesClicked.toggle()
						favoritesViewModel.addToFavorites(
							city: favoritesViewModel.searchedCityWeather!)

					},
					label: {
						Text("Add Weather to Favorites")
					}
				).padding()
					.background(.white)
					.foregroundStyle(.black)
					.clipShape(Capsule())

			}.background(
				themeManager.currentTheme.getColor(
					weather: favoritesViewModel.getSearchedCityWeatherType()))
		}
	}
	// Moves to
	func search() {
		print("searching")

		favoritesViewModel.searchWeatherForCityName(cityName: searchText)
	}
}

#Preview {
	NavigationStack {
		var configuration = Configuration()
		let locationSerice = LocationService()
		let internetMonitorService = InternetMonitorService()
		//Made it an environment object because It is a client that will be accesible on all screens.
		let weatherClient = WeatherClient(
			baseUrl: configuration.environment.weatherBaseURL)

		FavoritesView().environmentObject(
			FavoritesViewModel(
				favoriteWeatherRepository: FavoritesWeatherRepositoryImpl(
					weatherClient: weatherClient,
					internetMonitorService: internetMonitorService))
		).environmentObject(ThemesManager())
	}
}
