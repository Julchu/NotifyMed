//
//  ReminderCollection.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-26.
//  Copyright © 2020 Julian. All rights reserved.
//

import Foundation
import UIKit

class ReminderCollection: NSObject, NSCoding {
	var upcomingCollection = [Reminder]()
//	var deletedCollection = [Reminder]()
	var current: Int = 0
	
	let collectionKey = "collectionKey"
	let currentKey = "currentKey"
	
	override init() {
		super.init()
		setup()
	}
	
	required convenience init?(coder decoder: NSCoder) {
		self.init()
		upcomingCollection = (decoder.decodeObject(forKey: collectionKey) as? [Reminder])!
		current = (decoder.decodeInteger(forKey: currentKey))
	}
	
	func encode(with coder: NSCoder) {
		coder.encode(upcomingCollection, forKey: collectionKey)
		coder.encode(current, forKey: currentKey)
	}
	
	func getCurrentIndex() -> Int {
		return self.current
	}
	
	func getUpcomingCount() -> Int {
		return upcomingCollection.count
	}
	
	func getCurrentReminder() -> Reminder {
		return upcomingCollection[self.current]
	}
	
	func incrementCurrent() {
		self.current += 1
		if (self.current == self.upcomingCollection.count){
			self.current = 0
		}
	}
	
	func addReminder(reminderObj: Reminder){
		upcomingCollection.append(reminderObj)
	}
	
	func setCurrentIndex(index: Int) {
		current = index
	}
	
	func deleteReminderAt(index: Int) {
//		deletedCollection.remove(at: index)
	}
	
	func removeReminderAt(index: Int) {
		upcomingCollection.remove(at: index)
//		deletedCollection.append(upcomingCollection.remove(at: index))
	}
	
	func getReminderAt(index: Int) -> Reminder {
		return self.upcomingCollection[index]
	}
	
	func setup() {
		self.upcomingCollection.append(Reminder(medicineName: "Test Medicine 1", days: [true, false, true, false, true, false, true], frequency: "1", startDate: Date(), endDate: Date(), dismissed: false)!)
		self.upcomingCollection.append(Reminder(medicineName: "Test Medicine 2", days: [false, false, false, false, false, false, false], frequency: "2", startDate: Date(), endDate: Date(), dismissed: false)!)
		self.upcomingCollection.append(Reminder(medicineName: "Test Medicine 3", days: [true, true, true, true, true, true, true], frequency: "3", startDate: Date(), endDate: Date(), dismissed: false)!)
		self.upcomingCollection.append(Reminder(medicineName: "Test Medicine 4", days: [false, true, false, true, false, true, false], frequency: "4", startDate: Date(), endDate: Date(), dismissed: false)!)
	}
}

