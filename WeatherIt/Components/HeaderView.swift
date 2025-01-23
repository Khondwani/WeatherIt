//
//  HeaderView.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/21.
//

import SwiftUI

struct HeaderView: View {
	@EnvironmentObject private var themeManager: ThemesManager
	@EnvironmentObject private var weatherItViewModule: WeatherItViewModule
	
	@State private var isItSeaTheme: Bool = false
	var body: some View {
		ZStack(alignment: .top) {
			themeManager.currentTheme.getImage(
				weather: weatherItViewModule.getCurrentWeatherType()
			).resizable().aspectRatio(
				contentMode: .fit
			)
			VStack(alignment: .center) {
				Text("\(weatherItViewModule.getCurrentTemp())°").font(
					.system(size: 60)
				).foregroundColor(.white)
				Text(weatherItViewModule.getCurrentWeatherTitle().uppercased())
					.font(.system(size: 30)).tracking(2)
					.fontWeight(.medium).foregroundColor(.white)
			}.padding(.top, 100)

			HStack {
				Spacer()
				Toggle(
					isItSeaTheme ? "Sea" : "Forest",
					systemImage: isItSeaTheme
						? "sailboat.fill" : "tree.fill", isOn: $isItSeaTheme
				).toggleStyle(.button).font(.title3).tint(Color.white)
					.padding(
						.horizontal, 16
					).onChange(of: isItSeaTheme) {
						if isItSeaTheme {
							// set sea theme
							themeManager.setTheme(SeaTheme())
						} else {
							// set forest theme
							themeManager.setTheme(ForestTheme())
						}
					}
			}.padding(.top, 32)
		}
	}
}

#Preview {  // easier to just transfer the entire preview for now
	var configuration = Configuration()

	WeatherItView().environmentObject(
		WeatherItViewModule(
			 weatherRepository: WeatherRepositoryImpl(weatherClient: WeatherClient(baseUrl: configuration.environment.weatherBaseURL), locationServices: LocationService(), internetMonitorService: InternetMonitorService()))).environmentObject(ThemesManager())
}
