//
//  SharingMedicineCollection.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-26.
//  Copyright © 2020 Julian. All rights reserved.
//

import Foundation

class SharingMedicineCollection {
	static let sharedMedicineCollection = SharingMedicineCollection()
	
	let fileName = "medicineReminders.archive"
	private let rootKey = "rootKey"
	var medicineCollection: MedicineCollection?
	
	func dataFilePath() -> String {
		let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
		let documentsDirectory = paths[0] as NSString
		return documentsDirectory.appendingPathComponent(fileName) as String
	}
	
	func loadMedicineCollection() {
		let filePath = self.dataFilePath()
		if (FileManager.default.fileExists(atPath: filePath)) {
			let data = NSMutableData(contentsOfFile: filePath)!
			if (filePath != "") {
				let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
				SharingMedicineCollection.sharedMedicineCollection.medicineCollection = unarchiver.decodeObject(forKey: rootKey) as? MedicineCollection
				unarchiver.finishDecoding()
			}
		}
}
	
	func saveMedicineCollection() {
		let filePath = self.dataFilePath()
		let data = NSMutableData()
		let archiver = NSKeyedArchiver(forWritingWith: data)
		archiver.encode(SharingMedicineCollection.sharedMedicineCollection.medicineCollection, forKey: rootKey)
		archiver.finishEncoding()
		data.write(toFile: filePath, atomically: true)
	}
}
