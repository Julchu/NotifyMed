//
//  DeletedViewController.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-26.
//  Copyright © 2020 Julian. All rights reserved.
//

import UIKit

let deletedCellIdentifier = "DeletedIdentifier"

class DeletedViewController: UITableViewController {
	@IBOutlet weak var deletedTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		deletedTableView.delegate = self
		deletedTableView.dataSource = self
		
		_ = SharingReminderCollection()
		SharingReminderCollection.sharedReminderCollection.reminderCollection = ReminderCollection()
		SharingReminderCollection.sharedReminderCollection.loadReminderCollection()
		sharedReminderCollection = SharingReminderCollection.sharedReminderCollection.reminderCollection
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (sharedReminderCollection?.getUpcomingCount())!
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: deletedCellIdentifier, for: indexPath) as? UpcomingInfoCell
		
		if (cell == nil){
			cell = UpcomingInfoCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: deletedCellIdentifier) as UpcomingInfoCell
		}
		
		cell?.cellLabelUpcoming.text = sharedReminderCollection?.getReminderAt( index: indexPath.row).getName()
		return cell!
	}
	
	//	Swipe actions:
	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, tableView, completionHandler) in
			sharedReminderCollection?.removeReminderAt(index: indexPath.row)
			self.deletedTableView.deleteRows(at: [indexPath], with: .fade)
			completionHandler(true)
		}
		return UISwipeActionsConfiguration(actions: [deleteAction])
	}
	
	//	Clicking on cell
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		performSegue(withIdentifier: "infoViewSegueFromDismiss", sender: sharedReminderCollection?.upcomingCollection[indexPath.row])
		sharedReminderCollection?.setCurrentIndex(index: indexPath.row)
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/
	
//	@IBAction func unwindToUpcomingViewController(segue: UIStoryboardSegue) {
//		if let addViewController = segue.source as? AddViewController {
//			sharedMedicineCollection?.addMedicine(medicineObj: addViewController.addMedicine())
//			deletedTableView.reloadData()
//		} else if segue.source is InfoViewController {
//			deletedTableView.reloadData()
//		}
//	}
	
    // MARK: - Table view data source
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
	*/

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
