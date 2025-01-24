//
//  LazyViewWrapper.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/24.
//

import SwiftUICore
	// My wrapper to make sure the view is only loaded when clicked on!!
//
struct LazyView<Content: View>: View {
    let buildView: () -> Content
    
    init(_ build: @escaping () -> Content) {
        self.buildView = build
    }
    
    var body: Content {
        buildView()
    }
}
