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
var sharedMedicineCollection: MedicineCollection?

class UpcomingInfoCell: UITableViewCell {
	@IBOutlet weak var cellLabelUpcoming: UILabel!
}

class UpcomingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var upcomingTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		upcomingTableView.delegate = self
		upcomingTableView.dataSource = self
	
		_ = SharingMedicineCollection()
		SharingMedicineCollection.sharedMedicineCollection.medicineCollection = MedicineCollection()
		SharingMedicineCollection.sharedMedicineCollection.loadMedicineCollection()
		sharedMedicineCollection = SharingMedicineCollection.sharedMedicineCollection.medicineCollection
	}
	
//	MARK: - TableView
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (sharedMedicineCollection?.getUpcomingCount())!
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: upcomingCellIdentifier, for: indexPath) as? UpcomingInfoCell
		
		if (cell == nil) {
			cell = UpcomingInfoCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: upcomingCellIdentifier) as UpcomingInfoCell
		}
		
		cell?.cellLabelUpcoming.text = sharedMedicineCollection?.getMedicineAt( index: indexPath.row).getName()
		return cell!
	}
	
//	Swipe actions
	func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		var dismissAction = UIContextualAction.init()
		dismissAction = UIContextualAction(style: .normal, title: "Dismiss") { (action, tableView, completionHandler) in
			sharedMedicineCollection?.removeMedicineAt(index: indexPath.row)
			self.upcomingTableView.deleteRows(at: [indexPath], with: .fade)
			completionHandler(true)
		}
		dismissAction.backgroundColor = .systemGreen
		return UISwipeActionsConfiguration(actions: [dismissAction])
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		var deleteAction = UIContextualAction.init()
		deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, tableView, completionHandler) in
			sharedMedicineCollection?.removeMedicineAt(index: indexPath.row)
			self.upcomingTableView.deleteRows(at: [indexPath], with: .fade)
			completionHandler(true)
		}
		deleteAction.backgroundColor = .red
		
		return UISwipeActionsConfiguration(actions: [deleteAction])
	}
	
//	Clicking on cell
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		performSegue(withIdentifier: "infoViewSegueFromUpcoming", sender: sharedMedicineCollection?.upcomingCollection[indexPath.row])
		sharedMedicineCollection?.setCurrentIndex(index: indexPath.row)
	}
	
	@IBAction func unwindToUpcomingViewController(segue: UIStoryboardSegue) {
		upcomingTableView.reloadData()
	}
}
