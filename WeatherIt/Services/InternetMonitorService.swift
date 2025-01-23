//
//  InternetMonitorService.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/23.
//

import Foundation
import Network

class InternetMonitorService : ObservableObject {
	private let internetMonitor = NWPathMonitor()
	private let workerQueue = DispatchQueue(label: "InternetMonitoring")
	@Published var isInternetAvailable = false
	
	init() {
		setupInternetMonitor()
	}
	
	private func setupInternetMonitor() {
		internetMonitor.pathUpdateHandler = { path in
			if path.status == .satisfied {
				self.isInternetAvailable = true
			} else {
				self.isInternetAvailable = false
			}
		}
		internetMonitor.start(queue: workerQueue)
	}
}
