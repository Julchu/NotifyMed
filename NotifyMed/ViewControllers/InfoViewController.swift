//
//  InfoViewController.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-27.
//  Copyright © 2020 Julian. All rights reserved.
//

import UIKit
import AVFoundation
import os.log

class InfoViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
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
	
	@IBOutlet weak var buttonVoiceRecordingStop: UIButton!
	@IBOutlet weak var buttonVoiceRecordingPlay: UIButton!
	
	var audioPlayer: AVAudioPlayer!
	var audioRecorder: AVAudioRecorder!
	
//	Setting recording button toggles
	@IBAction func buttonVoiceRecordingPressed(_ sender: Any) {
		if audioRecorder?.isRecording == false {
			buttonVoiceRecordingPlay.isEnabled = false
			buttonVoiceRecordingStop.isEnabled = true
			audioRecorder?.record()
		}
	}
	
	@IBAction func buttonVoiceRecordingStopPressed(_ sender: Any) {
		buttonVoiceRecordingStop.isEnabled = false
		buttonVoiceRecordingPlay.isEnabled = true
		buttonVoiceRecording.isEnabled = true
		
		if audioRecorder?.isRecording == true {
			audioRecorder?.stop()
		} else {
			audioPlayer?.stop()
		}
	}
	
	@IBAction func buttonVoiceRecordingPlayPressed(_ sender: Any) {
		if audioRecorder?.isRecording == false {
			buttonVoiceRecordingStop.isEnabled = true
			buttonVoiceRecording.isEnabled = false
			
			do {
				try audioPlayer = AVAudioPlayer(contentsOf:	(audioRecorder?.url)!)
				audioPlayer!.delegate = self
				audioPlayer!.prepareToPlay()
				audioPlayer!.play()
			} catch let error as NSError {
				print("audioPlayer error: \(error.localizedDescription)")
			}
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupNewReminder()
		
		labelFrequency.textAlignment = .center
		
		setupAudio()
    }
	
	func setupAudio() {
//		Audio Recording
		let fileMgr = FileManager.default
		let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
		let soundFileURL = dirPaths[0].appendingPathComponent("recording.caf")
		
//		currentMedicine?.setVoiceRecording(voiceRecording: soundFileURL as NSURL)
		
		let recordSettings =
			[AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
			 AVEncoderBitRateKey: 16,
			 AVNumberOfChannelsKey: 2,
			 AVSampleRateKey: 44100.0] as [String : Any]
		
		let audioSession = AVAudioSession.sharedInstance()
		
		do {
			try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
		} catch let error as NSError {
			print("audioSession error: \(error.localizedDescription)")
		}
		
		do {
			try audioRecorder = AVAudioRecorder(url: soundFileURL, settings: recordSettings as [String : AnyObject])
			audioRecorder?.prepareToRecord()
		} catch let error as NSError {
			print("audioSession error: \(error.localizedDescription)")
		}
	}
	
//	AVAudioRecorderDelegate functions
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
		buttonVoiceRecording.isEnabled = true
		buttonVoiceRecordingStop.isEnabled = false
	}
	
	func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
		print("Audio Play Decode Error")
	}
	
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		print("Audio Recording Done")
	}
	
	func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
		print("Audio Record Encode Error")
	}
	
	func setupNewReminder() {
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
	
	@IBAction func unwindToInfoViewController(segue: UIStoryboardSegue) {
		setupNewReminder()
	}
}
