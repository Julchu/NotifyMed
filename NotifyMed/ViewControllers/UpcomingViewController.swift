//
//  UpcomingViewController.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-26.
//  Copyright © 2020 Julian. All rights reserved.
//

import UIKit

let customCellIdentifier = "UpcomingIdentifier"
let segueID = "editViewSegue"
var sharedMedicineCollection: MedicineCollection?

class MedicineInfoCell: UITableViewCell {
	@IBOutlet weak var medicineName: UILabel!
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
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (sharedMedicineCollection?.getCount())!
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: customCellIdentifier, for: indexPath) as? MedicineInfoCell
		
		if (cell == nil){
			cell = MedicineInfoCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: customCellIdentifier) as MedicineInfoCell
		}
		
		cell?.medicineName.text = sharedMedicineCollection?.getMedicineAt( index: indexPath.row).getName()
		return cell!
	}
	
//	Swipe actions:
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, tableView, completionHandler) in
			sharedMedicineCollection?.deleteMedicineAt(index: indexPath.row)
			self.upcomingTableView.deleteRows(at: [indexPath], with: .fade)
			completionHandler(true)
		}
		return UISwipeActionsConfiguration(actions: [deleteAction])
	}
	
//	Clicking on cell
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		performSegue(withIdentifier: segueID, sender: sharedMedicineCollection?.collection[indexPath.row])
		sharedMedicineCollection?.setCurrentIndex(index: indexPath.row)
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	
	@IBAction func unwindToUpcomingViewController(segue: UIStoryboardSegue) {
		if let addViewController = segue.source as? AddViewController {
			let medicine = addViewController.getMedicine()
			sharedMedicineCollection?.addMedicine(medicineObj: medicine)
			upcomingTableView.reloadData()
		} else if segue.source is EditViewController {
			upcomingTableView.reloadData()
		}
	}
}
