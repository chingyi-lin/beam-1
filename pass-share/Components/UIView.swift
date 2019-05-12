//
//  UIView.swift
//  pass-share
//
//  Created by CY on 2019/4/29.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func fadeIn(duration: TimeInterval = 0.4, delay: TimeInterval = 0.0) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: nil)  }
    
    func fadeOut(duration: TimeInterval = 0.4, delay: TimeInterval = 0.0) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
    func floatIn(dy: CGFloat, duration: TimeInterval = 0.4, delay: TimeInterval = 0.0) {
        UIView.animate(withDuration: duration, delay: delay, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: dy)
        }, completion: nil)  }
    
    func floatOut(duration: TimeInterval = 0.4, delay: TimeInterval = 0.0) {
        UIView.animate(withDuration: duration, delay: delay, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: nil)
    }
}
