//
//  DateFormatter+Extensions.swift
//  WeatherIt
//
//  Created by Khondwani Sikasote on 2025/01/21.
//
import Foundation

extension DateFormatter {
	
	static let YYYYMMddDash: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}()
	
	static let HHmmss: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm:ss"
		return formatter
	}()

	static let dayOnly: DateFormatter = {
		 let formatter = DateFormatter()
		 formatter.dateFormat = "EEEE"
		 return formatter
	}()
	
	static func stringDayOnly(from date: Date) -> String {
		return  DateFormatter.dayOnly.string(from: date)
	}
	// YYYY-MM-dd
	static func stringYYYYMMddDash(from date: Date) -> String {
		return  DateFormatter.YYYYMMddDash.string(from: date)
	}
	
	static func stringHHmmssColon(from date: Date) -> String {
		return  DateFormatter.HHmmss.string(from: date)
	}
	
	static func stringDateToDate(from dateString: String) -> Date? {
		return  DateFormatter.YYYYMMddDash.date(from: dateString)
	}
}
