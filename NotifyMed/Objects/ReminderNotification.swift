//
//  ReminderNotification.swift
//  NotifyMed
//
//  Created by Julian on 2020-04-15.
//  Copyright © 2020 Julian. All rights reserved.
//

import UIKit

class ReminderNotification: UNMutableNotificationContent {
	
//	https://developer.apple.com/documentation/usernotifications/scheduling_a_notification_locally_from_your_app#2980231
	
//	init(title: title, subtitle: subtitle: subtitle, body: body)
//	super(init)
//
//	let notification = UNMutableNotificationContent()
//
//	notification.title = "Reminder to take medicine"
//	notification.subtitle = ""
//	notification.body = ""
//	notification.sound = UNNotificationSound.default()
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
}

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
