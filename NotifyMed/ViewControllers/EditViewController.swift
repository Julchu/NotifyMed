//
//  EditViewController.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-26.
//  Copyright © 2020 Julian. All rights reserved.
//

import UIKit
import os.log

class EditViewController: UIViewController, UITextFieldDelegate {
	@IBOutlet weak var buttonSave: UIBarButtonItem!
	@IBOutlet weak var buttonCancel: UIBarButtonItem!
	@IBOutlet weak var textMedicineName: UITextField!
	@IBOutlet weak var buttonSunday: Checkbox!
	@IBOutlet weak var buttonMonday: Checkbox!
	@IBOutlet weak var buttonTuesday: Checkbox!
	@IBOutlet weak var buttonWednesday: Checkbox!
	@IBOutlet weak var buttonThursday: Checkbox!
	@IBOutlet weak var buttonFriday: Checkbox!
	@IBOutlet weak var buttonSaturday: Checkbox!
	@IBOutlet weak var textFrequency: UITextField!
	@IBOutlet weak var pickerStart: UIDatePicker!
	@IBOutlet weak var pickerEnd: UIDatePicker!
	
	var reminder: Reminder!
	var dateStartPlaceholder: Date!
	var dateEndPlaceholder: Date!
	
	@IBAction func buttonSundayPressed(_ sender: Checkbox) {
		buttonSunday.toggle()
	}
	
	@IBAction func buttonMondayPressed(_ sender: Checkbox) {
		buttonMonday.toggle()
	}
	
	@IBAction func buttonTuesdayPressed(_ sender: Checkbox) {
		buttonTuesday.toggle()
	}
	
	@IBAction func buttonWednesdayPressed(_ sender: Checkbox) {
		buttonWednesday.toggle()
	}
	
	@IBAction func buttonThusdayPressed(_ sender: Checkbox) {
		buttonThursday.toggle()
	}
	
	@IBAction func buttonFridayPressed(_ sender: Checkbox) {
		buttonFriday.toggle()
	}
	
	@IBAction func buttonSaturdayPressed(_ sender: Checkbox) {
		buttonSaturday.toggle()
	}
	
	@IBAction func pickerStartPressed(_ sender: UIDatePicker) {
		let dateStart = pickerStart.date
		let dateEnd = pickerEnd.date
		
		if (dateEnd < dateStart) {
			pickerStart.setDate(dateStartPlaceholder, animated: true)
			
			let alert = UIAlertController(title: "Invalid date(s)", message: "End date needs to be after start date.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
			self.present(alert, animated: true)
		}
		
		updateSaveButtonState()
	}
	
	@IBAction func pickerEndPressed(_ sender: UIDatePicker) {
		let dateStart = pickerStart.date
		let dateEnd = pickerEnd.date
		
		if (dateEnd < dateStart) {
			pickerEnd.setDate(dateEndPlaceholder, animated: true)
			
			let alert = UIAlertController(title: "Invalid date(s)", message: "End date needs to be after start date.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
			self.present(alert, animated: true)
		}
		
		updateSaveButtonState()
	}
	
	@IBAction func cancelPressed(_ sender: Any) {
		navigationController?.popViewController(animated: true)
		dismiss(animated: true, completion: nil)
	}
	
//	MARK: - viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		textMedicineName.delegate = self
		textFrequency.textAlignment = .center
		pickerStart.datePickerMode = .date
		pickerEnd.datePickerMode = .date
		dateStartPlaceholder = pickerStart.date
		dateEndPlaceholder = pickerEnd.date
		loadPreviousSave()
		updateSaveButtonState()
	}

//		Load previously saved medicine reminder information
	func loadPreviousSave() {
		let currentReminder = sharedReminderCollection?.getCurrentReminder()
		textMedicineName.text = currentReminder?.getName()
		textFrequency.text = currentReminder?.getFrequency()
		
		pickerStart.setDate((currentReminder?.getStartDate())!, animated: true)
		pickerEnd.setDate((currentReminder?.getEndDate())!, animated: true)
		
		buttonSunday.draw(toggled: (currentReminder?.getDays()[0])!)
		buttonMonday.draw(toggled: (currentReminder?.getDays()[1])!)
		buttonTuesday.draw(toggled: (currentReminder?.getDays()[2])!)
		buttonWednesday.draw(toggled: (currentReminder?.getDays()[3])!)
		buttonThursday.draw(toggled: (currentReminder?.getDays()[4])!)
		buttonFriday.draw(toggled: (currentReminder?.getDays()[5])!)
		buttonSaturday.draw(toggled: (currentReminder?.getDays()[6])!)
	}
	
	@IBAction func returnPressed(_ sender: Any) {
		textMedicineName.resignFirstResponder()
		textFrequency.resignFirstResponder()
	}
	
	@IBAction func screenTapped(_ sender: Any) {
		textMedicineName.resignFirstResponder()
		textFrequency.resignFirstResponder()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		buttonSave.isEnabled = false
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		updateSaveButtonState()
	}
	
	private func updateSaveButtonState() {
		let text = textMedicineName.text ?? ""
		buttonSave.isEnabled = !text.isEmpty
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let button = sender as? UIBarButtonItem, button === buttonSave else {
			os_log("The save button was not pressed, cancelling from Edit View", log: OSLog.default, type: .debug)
			return
		}
		editReminder()
		os_log("In EditViewController coming from EditViewController")
	}
	
	func editReminder() {
		let days = [buttonSunday.getBool(), buttonMonday.getBool(), buttonTuesday.getBool(), buttonWednesday.getBool(), buttonThursday.getBool(), buttonFriday.getBool(), buttonSaturday.getBool()]
		let currentReminder = sharedReminderCollection?.getCurrentReminder()
		currentReminder?.setName(medicineName: textMedicineName.text!)
		currentReminder?.setdays(days: days)
		currentReminder?.setFrequency(frequency: textFrequency.text!)
		currentReminder?.setStartDate(startDate: pickerStart.date)
		currentReminder?.setEndDate(endDate: pickerEnd.date)
		
		let reminderNotification = ReminderNotification()
		reminderNotification.setReminder(name: (currentReminder?.getName())!, days: (currentReminder?.getDays())!, uuids: (currentReminder?.getUuids())!)
	}
}
