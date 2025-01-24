//
//  ForecastCellView.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/21.
//

import SwiftUI

struct ForecastCellView: View {
	var dayLeading: String
	var iconImage: Image
	var tempTrailing: String
	var body: some View {
		HStack {
			Text(dayLeading).foregroundStyle(.white).font(.system(size: 18)).frame(maxWidth: .infinity, alignment: .leading)
			
			iconImage.resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center)
			
			Text("\(tempTrailing)°").foregroundStyle(.white).font(.system(size: 18)).fontWeight(.medium).frame(maxWidth: .infinity, alignment: .trailing)
		}.background(Color.clear).listRowBackground(Color.clear).listRowSeparator(.hidden).listRowInsets(.none)
	}
}
