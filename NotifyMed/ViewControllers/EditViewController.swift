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
	
	var medicine: Medicine!
	
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
	
	@IBAction func cancelPressed(_ sender: Any) {
		navigationController?.popViewController(animated: true)
		dismiss(animated: true, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		textMedicineName.delegate = self
		setup()
		updateSaveButtonState()
	}
	
	func setup() {
		let currentMedicine = sharedMedicineCollection?.currentMedicine()
		textMedicineName.text = currentMedicine?.getName()
		textFrequency.text = currentMedicine?.getFrequency()
		
		pickerStart.setDate((currentMedicine?.getStartDate())!, animated: true)
		pickerEnd.setDate((currentMedicine?.getEndDate())!, animated: true)
		
		buttonSunday.draw(toggled: (currentMedicine?.getdays()[0])!)
		buttonMonday.draw(toggled: (currentMedicine?.getdays()[1])!)
		buttonTuesday.draw(toggled: (currentMedicine?.getdays()[2])!)
		buttonWednesday.draw(toggled: (currentMedicine?.getdays()[3])!)
		buttonThursday.draw(toggled: (currentMedicine?.getdays()[4])!)
		buttonFriday.draw(toggled: (currentMedicine?.getdays()[5])!)
		buttonSaturday.draw(toggled: (currentMedicine?.getdays()[6])!)
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
		editMedicine()
		os_log("Coming from EditViewController")
	}
	
	func editMedicine() {
		let days = [buttonSunday.getBool(), buttonMonday.getBool(), buttonTuesday.getBool(), buttonWednesday.getBool(), buttonThursday.getBool(), buttonFriday.getBool(), buttonSaturday.getBool()]
		let currentMedicine = sharedMedicineCollection?.currentMedicine()
		currentMedicine?.setName(medicineName: textMedicineName.text!)
		currentMedicine?.setdays(days: days)
		currentMedicine?.setFrequency(frequency: textFrequency.text!)
		currentMedicine?.setStartDate(startDate: pickerStart.date)
		currentMedicine?.setEndDate(endDate: pickerEnd.date)
	}
}
