//
//  styles.swift
//  iOS_advanced_labTest1
//
//  Created by Litson Thomas on 2022-01-18.
//

import Foundation
import UIKit

func myButton(button: UIButton){
    button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    button.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    button.layer.shadowOpacity = 0.5
    button.layer.shadowRadius = 2.0
    button.layer.masksToBounds = false
    button.layer.cornerRadius = 10.0
    button.clipsToBounds = true
}
