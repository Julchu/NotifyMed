//
//  MedicineCollection.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-26.
//  Copyright © 2020 Julian. All rights reserved.
//

import Foundation
import UIKit

class MedicineCollection: NSObject, NSCoding {
	var upcomingCollection = [Medicine]()
//	var deletedCollection = [Medicine]()
	var current: Int = 0
	
	let collectionKey = "collectionKey"
	let currentKey = "currentKey"
	
	override init() {
		super.init()
		setup()
	}
	
	required convenience init?(coder decoder: NSCoder) {
		self.init()
		upcomingCollection = (decoder.decodeObject(forKey: collectionKey) as? [Medicine])!
		current = (decoder.decodeInteger(forKey: currentKey))
	}
	
	func encode(with coder: NSCoder) {
		coder.encode(upcomingCollection, forKey: collectionKey)
		coder.encode(current, forKey: currentKey)
	}
	
	func currentIndex() -> Int {
		return self.current
	}
	
	func getUpcomingCount()->Int {
		return upcomingCollection.count
	}
	
	func currentMedicine() -> Medicine {
		return upcomingCollection[self.current]
	}
	
	func incrementCurrent() {
		self.current += 1
		if (self.current == self.upcomingCollection.count){
			self.current = 0
		}
	}
	
	func addMedicine(medicineObj: Medicine){
		upcomingCollection.append(medicineObj)
	}
	
	func setCurrentIndex(index: Int) {
		current = index
	}
	
	func deleteMedicineAt(index: Int) {
//		deletedCollection.remove(at: index)
	}
	
	func removeMedicineAt(index: Int) {
		upcomingCollection.remove(at: index)
//		deletedCollection.append(upcomingCollection.remove(at: index))
	}
	
	func getMedicineAt(index: Int) -> Medicine {
		return self.upcomingCollection[index]
	}
	
	func setup() {
		self.upcomingCollection.append(Medicine(medicineName: "Test Medicine 1", days: [true, false, true, false, true, false, true], frequency: "1", startDate: Date(), endDate: Date(), dismissed: false)!)
		self.upcomingCollection.append(Medicine(medicineName: "Test Medicine 2", days: [false, false, false, false, false, false, false], frequency: "2", startDate: Date(), endDate: Date(), dismissed: false)!)
		self.upcomingCollection.append(Medicine(medicineName: "Test Medicine 3", days: [true, true, true, true, true, true, true], frequency: "3", startDate: Date(), endDate: Date(), dismissed: false)!)
		self.upcomingCollection.append(Medicine(medicineName: "Test Medicine 4", days: [false, true, false, true, false, true, false], frequency: "4", startDate: Date(), endDate: Date(), dismissed: false)!)
	}
}

