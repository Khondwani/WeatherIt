//
//  HeaderView.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/21.
//

import SwiftUI

struct HeaderView: View {
	var headerImage: Image
	var temp: String
	var title: String
	var body: some View {
		ZStack {
			headerImage.resizable().aspectRatio(
				contentMode: .fit
			)
			VStack(alignment: .center) {
				Text("\(temp)°").font(.system(size: 60)).foregroundColor(.white)
				Text(title.uppercased()).font(.system(size: 30)).tracking(2).fontWeight(.medium).foregroundColor(.white)
				Spacer()
					.frame(height: 60)
				
			}
		}
	}
}
