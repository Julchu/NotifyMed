//
//  ViewController.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-26.
//  Copyright © 2020 Julian. All rights reserved.
//

import UIKit
import os.log

class AddViewController: UIViewController, UITextFieldDelegate {
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

	var appDelegate = UIApplication.shared.delegate as? AppDelegate
	
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
	
	@IBAction func returnPressed(_ sender: Any) {
		textMedicineName.resignFirstResponder()
		textFrequency.resignFirstResponder()
	}
	
	@IBAction func screenTapped(_ sender: Any) {
		textMedicineName.resignFirstResponder()
		textFrequency.resignFirstResponder()
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
	
//	Lecture 7 - Tabbar Views 1:03:00 custom pickers
//	Lecture 9 - Codable 11:49 custom codable for saving audio
	private func updateSaveButtonState() {
		let text = textMedicineName.text ?? ""
				
		buttonSave.isEnabled = !text.isEmpty && pickerStart.date < pickerEnd.date
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
		updateSaveButtonState()
	}

//	MARK: - viewDidAppear
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let button = sender as? UIBarButtonItem, button === buttonSave else {
			os_log("The save button was not pressed, cancelling from Add View", log: OSLog.default, type: .debug)
			return
		}
		os_log("Save button pressed in Add View Controller, saving new Reminder", log: OSLog.default, type: .debug)
		sharedReminderCollection?.addReminder(reminderObj: addReminder())
	}
	
	func addReminder() -> Reminder {
		let days = [buttonSunday.getBool(), buttonMonday.getBool(), buttonTuesday.getBool(), buttonWednesday.getBool(), buttonThursday.getBool(), buttonFriday.getBool(), buttonSaturday.getBool()]
		let uuids = [UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString]
		let audioUuid = UUID().uuidString
		return Reminder(medicineName: textMedicineName.text!, days: days, frequency: textFrequency.text!, startDate: pickerStart.date, endDate: pickerEnd.date, dismissed: false, audioName: "\(audioUuid).mp4", uuids: uuids)!
	}
}

