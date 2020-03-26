//
//  SAFollowButton.swift
//  ToggleButton
//
//  Created by Sean Allen on 6/21/17.
//  Copyright © 2017 Sean Allen. All rights reserved.
//

import UIKit

class SAFollowButton: UIButton {
    
    var isOn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.cornerRadius = frame.size.height/2
        
        setTitleColor(UIColor.systemBlue, for: .normal)
        addTarget(self, action: #selector(SAFollowButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        
        isOn = bool
        
        let color = bool ? UIColor.systemBlue : .clear
        //let title = bool ? "Following" : "Follow"
        let titleColor = bool ? .white : UIColor.systemBlue
        
        //setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = color
    }

    
}
