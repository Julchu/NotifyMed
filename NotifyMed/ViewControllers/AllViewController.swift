//
//  AllViewController.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-26.
//  Copyright © 2020 Julian. All rights reserved.
//

import UIKit
import os.log

//class MedicineInfoCell: UITableViewCell {
//	@IBOutlet weak var medicineName: UILabel!
//}
let AllCellIdentifier = "AllIdentifier"
let DismissCellIdentifier = "DismissIdentifier"

class AllInfoCell: UITableViewCell {
	@IBOutlet weak var cellLabelAll: UILabel!
}

class DismissedInfoCell: UITableViewCell {
	@IBOutlet weak var cellLabelDismissed: UILabel!
}

class AllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var allTableView: UITableView!
	@IBOutlet weak var dismissedTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		allTableView.delegate = self
		allTableView.dataSource = self
		
		dismissedTableView.delegate = self
		dismissedTableView.dataSource = self
		
		_ = SharingReminderCollection()
		SharingReminderCollection.sharedReminderCollection.reminderCollection = ReminderCollection()
		SharingReminderCollection.sharedReminderCollection.loadReminderCollection()
		sharedReminderCollection = SharingReminderCollection.sharedReminderCollection.reminderCollection
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (sharedReminderCollection?.getUpcomingCount())!
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if tableView == allTableView {
			var cell = tableView.dequeueReusableCell(withIdentifier: AllCellIdentifier, for: indexPath) as? AllInfoCell
			
			if (cell == nil) {
				cell = AllInfoCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: AllCellIdentifier) as AllInfoCell
			}
			
			cell?.cellLabelAll.text = sharedReminderCollection?.getReminderAt( index: indexPath.row).getName()
			return cell!
		} else if tableView == dismissedTableView {
			var cell = tableView.dequeueReusableCell(withIdentifier: DismissCellIdentifier) as? DismissedInfoCell
			if (cell == nil) {
				cell = DismissedInfoCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: DismissCellIdentifier) as DismissedInfoCell
			}
			
			cell?.cellLabelDismissed.text = sharedReminderCollection?.getReminderAt( index: indexPath.row).getName()
		}
		return UITableViewCell()
	}
	
	//	Swipe actions:
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, tableView, completionHandler) in
			sharedReminderCollection?.removeReminderAt(index: indexPath.row)
			self.allTableView.deleteRows(at: [indexPath], with: .fade)
			completionHandler(true)
		}
		return UISwipeActionsConfiguration(actions: [deleteAction])
	}
	
	//	Clicking on cell
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if tableView == allTableView {
			tableView.deselectRow(at: indexPath, animated: true)
			performSegue(withIdentifier: "infoViewSegueFromAll", sender: sharedReminderCollection?.upcomingCollection[indexPath.row])
			sharedReminderCollection?.setCurrentIndex(index: indexPath.row)
			os_log("AllViewController: All clicked", log: .default, type: .info)
		} else if tableView == dismissedTableView {
			tableView.deselectRow(at: indexPath, animated: true)
			performSegue(withIdentifier: "infoViewSegueFromDismiss", sender: sharedReminderCollection?.upcomingCollection[indexPath.row])
			sharedReminderCollection?.setCurrentIndex(index: indexPath.row)
			os_log("AllViewController: Dismissed clicked", log: .default, type: .info)
		}
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/
	
//	@IBAction func unwindToViewController(segue: UIStoryboardSegue) {
//		if let addViewController = segue.source as? AddViewController {
//			sharedReminmderCollection?.addReminder(reminderObj: addViewController.addReminder())
//			allTableView.reloadData()
//		} else if segue.source is InfoViewController {
//			allTableView.reloadData()
//		}
//	}
}

