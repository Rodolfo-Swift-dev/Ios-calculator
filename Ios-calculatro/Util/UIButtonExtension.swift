//
//  UIButtonExtension.swift
//  Ios-calculatro
//
//  Created by rodoolfo gonzalez on 15-02-23.
//

import UIKit

extension UIButton {
    // Borde redondo
        func round() {
            layer.cornerRadius = bounds.height / 2
            clipsToBounds = true
        }
    // Brilla
        func shine() {
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 0.5
            }) { (completion) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.alpha = 1
                })
            }
        }
}
