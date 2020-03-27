//
//  Medicine.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-26.
//  Copyright © 2020 Julian. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Medicine: NSObject, NSCoding {
	private var medicineName: String
	private var days: [Bool] = Array(repeating: true, count: 7)
	private var frequency: String
	private var startDate: Date
	private var endDate: Date
	
	struct Keys {
		static let medicineName = "medicineName"
		static let days = "days"
		static let frequency = "frequency"
		static let startDate = "startDate"
		static let endDate = "endDate"
	}
	
	func encode(with coder: NSCoder) {
		coder.encode(medicineName, forKey: Keys.medicineName)
		coder.encode(days, forKey: Keys.days)
		coder.encode(frequency, forKey: Keys.frequency)
		coder.encode(startDate, forKey: Keys.startDate)
		coder.encode(endDate, forKey: Keys.endDate)
	}
	
	required convenience init?(coder decoder: NSCoder) {
		guard let medicineNameDecoded = decoder.decodeObject(forKey: Keys.medicineName) as? String else {
			os_log("Unable to decode the name for the medicine.", log: OSLog.default, type: .debug)
			return nil
		}
		
		let daysDecoded = (decoder.decodeObject(forKey: Keys.days) as? [Bool])!
		let frequencyDecoded = (decoder.decodeObject(forKey: Keys.frequency) as? String)!
		let startDateDecoded = (decoder.decodeObject(forKey: Keys.startDate) as? Date)!
		let endDateDecoded = (decoder.decodeObject(forKey: Keys.endDate) as? Date)!
		
		self.init(medicineName: medicineNameDecoded, days: daysDecoded, frequency: frequencyDecoded , startDate: startDateDecoded , endDate: endDateDecoded)
	}
	
	init?(medicineName: String, days: [Bool], frequency: String, startDate: Date, endDate: Date) {
		self.medicineName = medicineName
		self.frequency = frequency
		self.startDate = startDate
		self.endDate = endDate
		self.days = days
	}
	
	func changeName(medicineName: String) {
		self.medicineName = medicineName
	}
	
	func getName() -> String {
		return self.medicineName
	}
	
	func getdays() -> [Bool] {
		return self.days
	}
	
	func getFrequency() -> String {
		return self.frequency
	}
	
	func getStartDate() -> Date {
		return self.startDate
	}
	
	func getEndDate() -> Date {
		return self.endDate
	}
}
