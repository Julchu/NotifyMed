//
//  Checkbox.swift
//  NotifyMed
//
//  Created by Julian on 2020-03-26.
//  Copyright © 2020 Julian. All rights reserved.
//

import UIKit

class Checkbox: UIButton {
	private var toggled = true
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		draw()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		draw()
	}
	
	func draw() {
//		Making button a blue circle w/ white text (circle: 2, rounded: 4)
		let titleColor = toggled ? UIColor.white : .systemBlue
		let backgroundColor = toggled ? UIColor.systemBlue : .clear
		
//		Persistent blue border (for when toggled off)
		self.layer.borderWidth = 2.0
		self.layer.borderColor = UIColor.systemBlue.cgColor
		self.layer.cornerRadius = frame.size.height / 4
		self.setTitleColor(titleColor, for: UIControl.State.normal)
		self.backgroundColor = backgroundColor
	}

	func toggle() {
		self.toggled = !toggled
		draw()
	}

	
	/*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
