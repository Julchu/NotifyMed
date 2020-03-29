//
//  InfoViewController.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-27.
//  Copyright © 2020 Julian. All rights reserved.
//

import UIKit

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
		
        // Do any additional setup after loading the view.
    }
	
	func setup() {
		disableButtons()
		
		let currentMedicine = sharedMedicineCollection?.currentMedicine()
		labelMedicineName.text = currentMedicine?.getName()
		labelFrequency.text = currentMedicine?.getFrequency()
		
		let formatter = DateFormatter()
		formatter.dateFormat = "MMM d, yyyy"
		
		labelStart.text = formatter.string(from: (currentMedicine?.getStartDate())!)
		labelEnd.text = formatter.string(from: (currentMedicine?.getEndDate())!)
		
		buttonSunday.draw(toggled: (currentMedicine?.getdays()[0])!)
		buttonMonday.draw(toggled: (currentMedicine?.getdays()[1])!)
		buttonTuesday.draw(toggled: (currentMedicine?.getdays()[2])!)
		buttonWednesday.draw(toggled: (currentMedicine?.getdays()[3])!)
		buttonThursday.draw(toggled: (currentMedicine?.getdays()[4])!)
		buttonFriday.draw(toggled: (currentMedicine?.getdays()[5])!)
		buttonSaturday.draw(toggled: (currentMedicine?.getdays()[6])!)
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	
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
//		if let editViewController = segue.source as? EditViewController {
			
//			let medicine = editViewController.getMedicine()
//			sharedMedicineCollection?.addMedicine(medicineObj: medicine)

//		}
		if segue.source is EditViewController {
			print("banmanaaefww")
		}
		print("banmanaaefww222")
	}
}
