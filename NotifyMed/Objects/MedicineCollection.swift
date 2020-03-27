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
	var collection = [Medicine]()
	var current: Int = 0
	
	let collectionKey = "collectionKey"
	let currentKey = "currentKey"
	
	override init() {
		super.init()
		setup()
	}
	
	required convenience init?(coder decoder: NSCoder) {
		self.init()
		collection = (decoder.decodeObject(forKey: collectionKey) as? [Medicine])!
		current = (decoder.decodeInteger(forKey: currentKey))
	}
	
	func encode(with coder: NSCoder) {
		coder.encode(collection, forKey: collectionKey)
		coder.encode(current, forKey: currentKey)
	}
	
	func currentIndex() -> Int {
		return self.current
	}
	
	func getCount()->Int {
		return collection.count
	}
	
	func currentMedicine() -> Medicine {
		return collection[self.current]
	}
	
	func incrementCurrent() {
		self.current += 1
		if (self.current == self.collection.count){
			self.current = 0
		}
	}
	
	func addMedicine(medicineObj: Medicine){
		collection.append(medicineObj)
	}
	
	func removeCurrentMedicine() {
		if (self.current == self.collection.count - 1){
			collection.remove(at: current)
			self.current = 0
		}
		else{
			collection.remove(at: current)
		}
	}
	
	func setCurrentIndex(index: Int) {
		current = index
	}
	
	func deleteMedicineAt(index: Int) {
		collection.remove(at: index)
	}
	
	func getMedicineAt(index: Int) -> Medicine {
		return self.collection[index]
	}
	
	func setup() {
		self.collection.append(Medicine(medicineName: "Test Medicine 1", frequency: "2", startDate: Date(), endDate: Date())!)
		self.collection.append(Medicine(medicineName: "Test Medicine 2", frequency: "2", startDate: Date(), endDate: Date())!)
		self.collection.append(Medicine(medicineName: "Test Medicine 3", frequency: "2", startDate: Date(), endDate: Date())!)
		self.collection.append(Medicine(medicineName: "Test Medicine 4", frequency: "2", startDate: Date(), endDate: Date())!)
	}
}

