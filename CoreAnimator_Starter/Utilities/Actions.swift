//
//  Actions.swift
//  CoreAnimator_Starter
//
//  Created by Mitya Kim on 10/12/22.
//  Copyright © 2022 Paradigm Shift Development, LLC. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

class GradientColorAction: NSObject, CAAction {
    func run(forKey event: String, object anObject: Any, arguments dict: [AnyHashable : Any]?) {
        
        let layer = anObject as! CAGradientLayer
        let colorChange = CABasicAnimation(keyPath: AnimationHelper.gradientColors)
        let finalColors = [
            UIColor.brown.cgColor,
            UIColor.green.cgColor,
            UIColor.red.cgColor
        ]
        
        colorChange.duration = 2
        colorChange.fromValue = layer.colors
        colorChange.toValue = finalColors
        colorChange.fillMode = CAMediaTimingFillMode.backwards
        colorChange.beginTime = AnimationHelper.addDelay(time: 3)
        
        layer.colors = finalColors
        layer.add(colorChange, forKey: "gradient_color_swap")
    }
}


class GradientLocationAction: NSObject, CAAction {
    func run(forKey event: String, object anObject: Any, arguments dict: [AnyHashable : Any]?) {
        
        let layer = anObject as! CAGradientLayer
        let locationChange = CABasicAnimation(keyPath: AnimationHelper.gradientLocations)
        let finalLocations: [NSNumber] = [0.0, 0.9, 1.0]
        
        locationChange.duration = 2.0
        locationChange.fromValue = layer.locations
        locationChange.toValue = finalLocations
        locationChange.beginTime = AnimationHelper.addDelay(time: 1)
        locationChange.fillMode = CAMediaTimingFillMode.backwards
        
        layer.locations = finalLocations
        layer.add(locationChange, forKey: "gradient_locations")
    }
    
    
}
