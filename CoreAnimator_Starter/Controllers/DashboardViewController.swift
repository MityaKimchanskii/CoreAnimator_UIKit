//
//  DashboardViewController.swift
//  CoreAnimator
//
//  Created by Mitya Kim on 9/13/22.
//

import UIKit

class DashboardViewController: UIViewController {
    
    // Shape layers
    let gradientLayer = CAGradientLayer()
    var circle = CAShapeLayer()
    var square = CAShapeLayer()
    var triangle = CAShapeLayer()
    
    // Gradient colors
    let colors = [
        UIColor.blue.cgColor,
        UIColor.darkGray.cgColor,
        UIColor.black.cgColor
    ]
    
    // MARK: Appearance
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Gradient setup
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Shape setup
        square = AnimationHelper.squareShapeLayer()
        view.layer.addSublayer(square)
    }

}
