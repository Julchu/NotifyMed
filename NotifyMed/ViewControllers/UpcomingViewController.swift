//
//  UpcomingViewController.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-26.
//  Copyright © 2020 Julian. All rights reserved.
//

import UIKit
import os.log

let upcomingCellIdentifier = "UpcomingIdentifier"
var sharedReminderCollection: ReminderCollection?

class UpcomingInfoCell: UITableViewCell {
	@IBOutlet weak var cellLabelUpcoming: UILabel!
}

class UpcomingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var upcomingTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		upcomingTableView.delegate = self
		upcomingTableView.dataSource = self
	
		_ = SharingReminderCollection()
		SharingReminderCollection.sharedReminderCollection.reminderCollection = ReminderCollection()
		SharingReminderCollection.sharedReminderCollection.loadReminderCollection()
		sharedReminderCollection = SharingReminderCollection.sharedReminderCollection.reminderCollection
	}
	
//	MARK: - TableView
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (sharedReminderCollection?.getUpcomingCount())!
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: upcomingCellIdentifier, for: indexPath) as? UpcomingInfoCell
		
		if (cell == nil) {
			cell = UpcomingInfoCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: upcomingCellIdentifier) as UpcomingInfoCell
		}
		
		cell?.cellLabelUpcoming.text = sharedReminderCollection?.getReminderAt( index: indexPath.row).getName()
		return cell!
	}
	
//	MARK:- Swipe actions
//	Swipe right to dismiss
/*
	func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		var dismissAction = UIContextualAction.init()
		dismissAction = UIContextualAction(style: .normal, title: "Dismiss") { (action, tableView, completionHandler) in
			ReminderNotification().removeReminder(uuids: (sharedReminderCollection?.getReminderAt(index: indexPath.row).getUuids())!)
//			sharedReminderCollection?.removeReminderAt(index: indexPath.row)
//			self.upcomingTableView.deleteRows(at: [indexPath], with: .fade)
			completionHandler(true)
		}
		dismissAction.backgroundColor = .systemGreen
		return UISwipeActionsConfiguration(actions: [dismissAction])
	}
*/
	
//Swipe left to delete
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		var deleteAction = UIContextualAction.init()
		deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, tableView, completionHandler) in
			ReminderNotification().removeReminder(uuids: (sharedReminderCollection?.getReminderAt(index: indexPath.row).getUuids())!)
			sharedReminderCollection?.removeReminderAt(index: indexPath.row)
			self.upcomingTableView.deleteRows(at: [indexPath], with: .fade)
			completionHandler(true)
		}
		deleteAction.backgroundColor = .red
		
		return UISwipeActionsConfiguration(actions: [deleteAction])
	}
	
//	Clicking on cell
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		sharedReminderCollection?.setCurrentIndex(index: indexPath.row)
		performSegue(withIdentifier: "infoViewSegueFromUpcoming", sender: sharedReminderCollection?.upcomingCollection[indexPath.row])
		
		let uuids = sharedReminderCollection?.upcomingCollection[indexPath.row].getUuids()
		ReminderNotification().getNotificationList(uuids: uuids!)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "infoViewSegueFromUpcoming" {
			if let infoViewController = segue.destination as? InfoViewController {
				infoViewController.title = sharedReminderCollection?.getCurrentReminder().getName()
			}
		}
	}
	
	@IBAction func unwindToUpcomingViewController(segue: UIStoryboardSegue) {
		upcomingTableView.reloadData()
	}
}
