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
	private var days: [Bool] = Array(repeating: true, count: 7)
	private var triggers = [UNCalendarNotificationTrigger?](repeating: nil, count:7)
	private var uuids = [String](repeating: "", count:7)
	private var requests = [UNNotificationRequest?](repeating: nil, count: 7)
	
	
	init(days: [Bool]) {
		self.days = days
		newUuids()
//		setReminder(uuids: self.uuids)
	}
	
	private func newUuids() {
		for i in 0...6 {
			uuids[i] = UUID().uuidString
		}
	}
	
	func getUuids() -> [String] {
		return self.uuids
	}
	
	func setReminder(uuids: [String]) {
		// Notification content
		let content = UNMutableNotificationContent()
		content.title = "NotifyMed"
		content.subtitle = "Reminder"
		content.body = "Reminder to take your medicine"
		content.sound = UNNotificationSound.default
		
		let notificationCenter = UNUserNotificationCenter.current()
		notificationCenter.removePendingNotificationRequests(withIdentifiers: uuids)
		
		for i in 0...6 {
//			Check if days[i] is true
			if days[i] {
				let dateComponents = DateComponents(calendar: Calendar.current, hour: 14, weekday: i)
				let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
				requests[i] = UNNotificationRequest(identifier: uuids[i], content: content, trigger: trigger)
								
				notificationCenter.add(requests[i]!) { (error) in
					if error != nil {
						// Handle any errors.
						os_log("Did not add notification request", log: OSLog.default, type: .debug)
					} else {
						os_log("Notification added for day: %@", log: OSLog.default, type: .debug, i)
					}
				}
			}
		}
	}
}

//	Custom gestures/interactions for notifications
//	https://developer.apple.com/documentation/usernotifications/handling_notifications_and_notification-related_actions

//	init(title: title, subtitle: subtitle: subtitle, body: body)
//	super(init)

//	https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app#2980231
//
// let notification = UNMutableNotificationContent()


//
//	content.title = "Reminder to take medicine"
//	content.subtitle = ""
//	content.body = ""
//	content.sound = UNNotificationSound.default
//
//	// Configure the recurring date.
//	var dateComponents = DateComponents()
//	dateComponents.calendar = Calendar.current
//
//	dateComponents.weekday = 3  // Tuesday
//	dateComponents.hour = 14    // 14:00 hours
//
//	// Create the trigger as a repeating event.
//	let trigger = UNCalendarNotificationTrigger(
//		dateMatching: dateComponents, repeats: true)

//	// Create the request
//	let uuidString = UUID().uuidString
//	let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
//
//	// Schedule the request with the system.
//	let notificationCenter = UNUserNotificationCenter.current()
//	notificationCenter.add(request) { (error) in
//		if error != nil {
//			// Handle any errors.
//		}
//	}

/*
https://stackoverflow.com/questions/50966164/set-repeat-local-notification-from-date

let notification = UNMutableNotificationContent()
notification.title = ""
notification.subtitle = ""
notification.body = ""
notification.sound = UNNotificationSound.default()


notification.userInfo =  userInfo
notification.title = Title
notification.body = Message

let timeStr = time
let splitTime:[String] = timeStr.components(separatedBy: ":")
var dayComponent = DateComponents()
dayComponent.weekday = day as? Int //[1 to 7 get randomly]
dayComponent.hour = Int(splitTime[0])
dayComponent.minute = Int(splitTime[1])

let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dayComponent, repeats: true)
let lnMessageId:String = message
let dayRequest = UNNotificationRequest(identifier: lnMessageId , content: notification, trigger: notificationTrigger)
UNUserNotificationCenter.current().add(dayRequest, withCompletionHandler: {(_ error: Error?) -> Void in
if error == nil
{
//print("success")
}
else
{
//print("UNUserNotificationCenter Error : \(String(describing: error?.localizedDescription))")
}
})



*/
