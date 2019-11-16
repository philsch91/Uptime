//
//  ColorCompatibility.swift
//  Uptime
//
//  Created by philipp on 16.11.19.
//  Copyright © 2019 Philipp Schunker. All rights reserved.
//

import UIKit

public enum ColorCompatibility {
    static var label: UIColor {
        if #available(iOS 13, *) {
            return UIColor.label
        }
        return UIColor.black
        //return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    }
    
    static var secondaryLabel: UIColor {
        if #available(iOS 13, *) {
            return UIColor.secondaryLabel
        }
        return UIColor(red: 0.23529411764705882, green: 0.23529411764705882, blue: 0.2627450980392157, alpha: 0.6)
    }
}
