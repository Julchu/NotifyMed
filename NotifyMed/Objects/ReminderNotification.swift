//
//  ReminderNotification.swift
//  NotifyMed
//
//  Created by Julian on 2020-04-15.
//  Copyright © 2020 Julian. All rights reserved.
//

import UIKit
import os.log

class ReminderNotification {
	func setReminder(days: [Bool], uuids: [String]) {
		// Notification content
		let content = UNMutableNotificationContent()
		content.title = "NotifyMed"
		content.subtitle = "Reminder to take your medicine"
		content.body = "Click okay to confirm that you've taken your medicine"
		content.sound = UNNotificationSound.default
		content.badge = 1
		content.categoryIdentifier = "categories"
		
		let notificationCenter = UNUserNotificationCenter.current()
		notificationCenter.removePendingNotificationRequests(withIdentifiers: uuids)
		
		for i in 0..<7 {
//			Check if days[i] is true
			if days[i] {
				let dateComponents = DateComponents(calendar: Calendar.current, hour: 12, minute: 00, weekday: i + 1)
//				let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
				
//				For demo purposes:
				let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(i) + 2.0, repeats: false)
				
				let request = UNNotificationRequest(identifier: uuids[i], content: content, trigger: trigger)
								
				notificationCenter.add(request) { (error) in
					if error != nil {
						// Handle any errors.
						os_log("Did not add notification request", log: OSLog.default, type: .debug)
					}
				}
			}
		}
		let dismissAction = UNNotificationAction(identifier: "Dismiss", title: "Later", options: [])
		let deleteAction = UNNotificationAction(identifier: "Delete", title: "Okay", options: [.destructive])
		let category = UNNotificationCategory(identifier: "categories", actions: [dismissAction, deleteAction], intentIdentifiers: [], options: [])
		notificationCenter.setNotificationCategories([category])
	}
	
	func removeReminder(uuids: [String]) {
		os_log("Removing notifications for ids: %@", log: .default, type: .info, uuids)
		let notificationCenter = UNUserNotificationCenter.current()
		notificationCenter.removePendingNotificationRequests(withIdentifiers: uuids)
	}
	
	func getNotificationList(uuids: [String]) {
		
		var uuidDict: [String: String] = [:]
		for id in uuids {
			uuidDict[id] = "id"
		}
		
		UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
			for notification in notifications {
				if let id = uuidDict[notification.identifier] {
					os_log("Notification for id = %@: %@", log: .default, type: .info, id, notification)
				}
			}
		}
	}
}
