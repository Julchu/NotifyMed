//
//  Medicine.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-26.
//  Copyright © 2020 Julian. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import os.log

class Reminder: NSObject, NSCoding {
	private var medicineName: String
	private var days: [Bool] = Array(repeating: true, count: 7)
	private var frequency: String
	private var startDate: Date
	private var endDate: Date
	private var dismissed: Bool
    private var audioName : String
	private var uuids: [String] = Array(repeating: "", count:7)
	
	struct Keys {
		static let medicineName = "medicineName"
		static let days = "days"
		static let frequency = "frequency"
		static let startDate = "startDate"
		static let endDate = "endDate"
		static let dismissed = "dismissed"
        static let audioName = "audioName"
		static let uuids = "uuids"
	}
	
	func encode(with coder: NSCoder) {
		coder.encode(medicineName, forKey: Keys.medicineName)
		coder.encode(days, forKey: Keys.days)
		coder.encode(frequency, forKey: Keys.frequency)
		coder.encode(startDate, forKey: Keys.startDate)
		coder.encode(endDate, forKey: Keys.endDate)
		coder.encode(dismissed, forKey: Keys.dismissed)
    coder.encode(audioName,forKey: Keys.audioName)
    coder.encode(uuids, forKey: Keys.uuids)
	}
  
	init?(medicineName: String, days: [Bool], frequency: String, startDate: Date, endDate: Date, dismissed: Bool, audioName: String, uuids: [String]) {
		self.medicineName = medicineName
		self.frequency = frequency
		self.startDate = startDate
		self.endDate = endDate
		self.days = days
		self.dismissed = dismissed
        self.audioName = audioName
		self.uuids = uuids
		
		let reminderNotification = ReminderNotification()
		reminderNotification.setReminder(name: self.medicineName, days: self.days, uuids: self.uuids)
		
		os_log("Notification UUIDs for %@: %@", log: .default, type: .info, self.medicineName, self.uuids)
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
		let dismissedDecoded = decoder.decodeBool(forKey: Keys.dismissed)
    let uuids = decoder.decodeObject(forKey: Keys.uuids)
    let audioNameDecoded = (decoder.decodeObject(forKey: Keys.audioName) as? String)!

    self.init(medicineName: medicineNameDecoded, days: daysDecoded, frequency: frequencyDecoded , startDate: startDateDecoded , endDate: endDateDecoded, dismissed: dismissedDecoded, audioName: audioNameDecoded, uuids: uuids as! [String])
	}
	
	func getUuids() -> [String] {
		return self.uuids
	}
  
	func getName() -> String {
		return self.medicineName
	}
  
	func getDays() -> [Bool] {
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

	func getAudioName()->String{
		return self.audioName
	}
	
	func isDismissed() -> Bool {
		return self.dismissed
	}
	
	func setName(medicineName: String) {
		self.medicineName = medicineName
	}
	
	func setdays(days: [Bool]) {
		self.days = days
	}
	
	func setFrequency(frequency: String) {
		self.frequency = frequency
	}
	
	func setStartDate(startDate: Date) {
		self.startDate = startDate
	}
	
	func setEndDate(endDate: Date) {
		self.endDate = endDate
	}
	
	func setDismissed(dismissed: Bool) {
		self.dismissed = dismissed
	}
	
    func setAudioName(audioName: String){
        self.audioName = audioName
	}

//	Generating new strings
	func setUuids(uuids: [String]) {
		self.uuids = uuids
	}
}
