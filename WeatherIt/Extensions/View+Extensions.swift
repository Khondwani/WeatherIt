//
//  View+Extensions.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/23.
//

import Foundation
import SwiftUI

extension View {
	func emptyListView<T: Collection, V: View>(_ data: Binding<T>, @ViewBuilder replacementView: @escaping () -> V) -> some View {
		return self.modifier(EmptyListViewModifier(listData: data, replacementView: replacementView))
	}
}
// Must conform to Collection and View
struct EmptyListViewModifier<T: Collection, V: View>: ViewModifier {
	@Binding
	var listData: T
	
	@ViewBuilder
	var replacementView: () -> V
	
	func body(content: Content) -> some View {
		if !listData.isEmpty {
			 content
		} else {
			replacementView()
		}
	}
}
