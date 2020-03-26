//
//  ViewController.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-26.
//  Copyright © 2020 Julian. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
	private let imageTrue = "PickedDay.png"
	
	@IBOutlet weak var buttonSunday: Checkbox!
	@IBOutlet weak var buttonMonday: Checkbox!
	@IBOutlet weak var buttonTuesday: Checkbox!
	@IBOutlet weak var buttonWednesday: Checkbox!
	@IBOutlet weak var buttonThursday: Checkbox!
	@IBOutlet weak var buttonFriday: Checkbox!
	@IBOutlet weak var buttonSaturday: Checkbox!
	@IBOutlet weak var textReminderName: UITextField!
	@IBOutlet weak var textFrequency: UITextField!
	@IBOutlet weak var buttonSave: UIBarButtonItem!
	
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
	
	@IBAction func buttonSavePressed(_ sender: Any) {
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
				
	}

}

