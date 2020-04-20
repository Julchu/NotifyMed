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
	@IBOutlet weak var buttonVoiceRecordingPlay: UIButton!
	
	var audioPlayer: AVAudioPlayer!
	var audioRecorder: AVAudioRecorder!
    var recordingSession : AVAudioSession!
    var audioName : String!
	
//	Setting recording button toggles
	@IBAction func buttonVoiceRecordingPressed(_ sender: Any) {
        if audioRecorder == nil{
			os_log("Audio Recorder started recording audio", log: .default, type: .info)
			let filename = getDirectory().appendingPathComponent("\(String(describing: audioName)).m4a")
            
            let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            do {
                audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.record()
				buttonVoiceRecordingPlay.isEnabled = false
				buttonVoiceRecording.setImage(UIImage(systemName: "stop.circle"), for: .normal)
            } catch {
				os_log("Problem recording audio in InfoViewController.swift", log: .default, type: .info)
            }
        } else {
            audioRecorder.stop()
            audioRecorder = nil
			buttonVoiceRecording.setImage(UIImage(systemName: "mic"), for: .normal)
            buttonVoiceRecordingPlay.isEnabled = true
        }
	}
	
	@IBAction func buttonVoiceRecordingPlayPressed(_ sender: Any) {
		let path = getDirectory().appendingPathComponent("\(String(describing: audioName)).m4a")

			do {
				try audioPlayer = AVAudioPlayer(contentsOf:	path)
				audioPlayer!.delegate = self
				audioPlayer!.prepareToPlay()
				audioPlayer!.play()
			} catch let error as NSError {
				os_log("AudioPlayer error: %@", log: .default, type: .info, error.localizedDescription)
			}
		}
        
    override func viewDidLoad() {
        super.viewDidLoad()
		let currentReminder = sharedReminderCollection?.getCurrentReminder()
        audioName = currentReminder?.getAudioName()
        recordingSession = AVAudioSession.sharedInstance()
        AVAudioSession.sharedInstance().requestRecordPermission{ (hasPermission) in
            if hasPermission {
				os_log("We have Permission to use Microphone.", log: .default, type: .info)
            }
        }
		
		setupNewReminder()
		
		labelFrequency.textAlignment = .center
    }
    
    func getDirectory()->URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory=paths[0]
        return documentDirectory
    }
	
//	AVAudioRecorderDelegate functions
	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
		buttonVoiceRecording.isEnabled = true
	}
	
	func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
		os_log("Audio Play Decode Error", log: .default, type: .info)
	}
	
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		os_log("Audio Recording Done", log: .default, type: .info)
	}
	
	func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
		os_log("Audio Record Encode Error", log: .default, type: .info)
	}
	
	func setupNewReminder() {
		disableButtons()
		
//		Get selected medicine reminder information
		let currentReminder = sharedReminderCollection?.getCurrentReminder()
		labelMedicineName.text = currentReminder?.getName()
		labelFrequency.text = currentReminder?.getFrequency()
		
//		Getting start and end dates
		let formatter = DateFormatter()
		formatter.dateFormat = "MMM d, yyyy"
		labelStart.text = formatter.string(from: (currentReminder?.getStartDate())!)
		labelEnd.text = formatter.string(from: (currentReminder?.getEndDate())!)
		
//		Setting day button states
		buttonSunday.draw(toggled: (currentReminder?.getDays()[0])!)
		buttonMonday.draw(toggled: (currentReminder?.getDays()[1])!)
		buttonTuesday.draw(toggled: (currentReminder?.getDays()[2])!)
		buttonWednesday.draw(toggled: (currentReminder?.getDays()[3])!)
		buttonThursday.draw(toggled: (currentReminder?.getDays()[4])!)
		buttonFriday.draw(toggled: (currentReminder?.getDays()[5])!)
		buttonSaturday.draw(toggled: (currentReminder?.getDays()[6])!)
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
