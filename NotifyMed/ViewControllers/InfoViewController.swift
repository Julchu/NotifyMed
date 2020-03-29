//
//  InfoViewController.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-27.
//  Copyright © 2020 Julian. All rights reserved.
//

import UIKit
import os.log

class InfoViewController: UIViewController {
	
	@IBOutlet weak var buttonEdit: UIBarButtonItem!
	@IBOutlet weak var labelMedicineName: UILabel!
	@IBOutlet weak var buttonSunday: Checkbox!
	@IBOutlet weak var buttonMonday: Checkbox!
	@IBOutlet weak var buttonTuesday: Checkbox!
	@IBOutlet weak var buttonWednesday: Checkbox!
	@IBOutlet weak var buttonThursday: Checkbox!
	@IBOutlet weak var buttonFriday: Checkbox!
	@IBOutlet weak var buttonSaturday: Checkbox!
	@IBOutlet weak var labelFrequency: UILabel!
	@IBOutlet weak var labelStart: UILabel!
	@IBOutlet weak var labelEnd: UILabel!
	@IBOutlet weak var buttonVoiceRecording: UIButton!
	@IBOutlet weak var buttonVideoRecording: UIButton!
	
	@IBOutlet var infoView: UIView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
    }
	
	func setup() {
		disableButtons()
		
//		Get selected medicine reminder information
		let currentMedicine = sharedMedicineCollection?.currentMedicine()
		labelMedicineName.text = currentMedicine?.getName()
		labelFrequency.text = currentMedicine?.getFrequency()
		
//		Getting start and end dates
		let formatter = DateFormatter()
		formatter.dateFormat = "MMM d, yyyy"
		labelStart.text = formatter.string(from: (currentMedicine?.getStartDate())!)
		labelEnd.text = formatter.string(from: (currentMedicine?.getEndDate())!)
		
//		Setting day button states
		buttonSunday.draw(toggled: (currentMedicine?.getdays()[0])!)
		buttonMonday.draw(toggled: (currentMedicine?.getdays()[1])!)
		buttonTuesday.draw(toggled: (currentMedicine?.getdays()[2])!)
		buttonWednesday.draw(toggled: (currentMedicine?.getdays()[3])!)
		buttonThursday.draw(toggled: (currentMedicine?.getdays()[4])!)
		buttonFriday.draw(toggled: (currentMedicine?.getdays()[5])!)
		buttonSaturday.draw(toggled: (currentMedicine?.getdays()[6])!)
	}
	
//	Disabling button interaction
	func disableButtons() {
		buttonSunday.isUserInteractionEnabled = false
		buttonMonday.isUserInteractionEnabled = false
		buttonTuesday.isUserInteractionEnabled = false
		buttonWednesday.isUserInteractionEnabled = false
		buttonThursday.isUserInteractionEnabled = false
		buttonFriday.isUserInteractionEnabled = false
		buttonSaturday.isUserInteractionEnabled = false
	}
	
	@IBAction func unwindToViewController(segue: UIStoryboardSegue) {
		if segue.source is EditViewController {
			os_log("Coming from EditViewController")
		}
		os_log("to InfoViewController")
	}
}
