//
//  InlinePrimaryButton.swift
//  pass-share
//
//  Created by CY on 2019/5/6.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit

class InlinePrimaryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(red:0.06, green:0.11, blue:0.28, alpha:1.0)
        self.setTitleColor(UIColor.white, for: .normal)
    }
}
