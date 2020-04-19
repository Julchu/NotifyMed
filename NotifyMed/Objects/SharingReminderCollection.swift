//
//  SharingReminderCollection.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-26.
//  Copyright © 2020 Julian. All rights reserved.
//

import Foundation

class SharingReminderCollection {
	static let sharedReminderCollection = SharingReminderCollection()
	
	let fileName = "medicineReminders.archive"
	private let rootKey = "rootKey"
	var reminderCollection: ReminderCollection?
	
	func dataFilePath() -> String {
		let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
		let documentsDirectory = paths[0] as NSString
		return documentsDirectory.appendingPathComponent(fileName) as String
	}
	
	func loadReminderCollection() {
		let filePath = self.dataFilePath()
		if (FileManager.default.fileExists(atPath: filePath)) {
			let data = NSMutableData(contentsOfFile: filePath)!
			if (filePath != "") {
				let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
				SharingReminderCollection.sharedReminderCollection.reminderCollection = unarchiver.decodeObject(forKey: rootKey) as? ReminderCollection
				unarchiver.finishDecoding()
			}
		}
}
	
	func saveReminderCollection() {
		let filePath = self.dataFilePath()
		let data = NSMutableData()
		let archiver = NSKeyedArchiver(forWritingWith: data)
		archiver.encode(SharingReminderCollection.sharedReminderCollection.reminderCollection, forKey: rootKey)
		archiver.finishEncoding()
		data.write(toFile: filePath, atomically: true)
	}
}
