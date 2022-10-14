//
//  DashboardViewController.swift
//  CoreAnimator
//
//  Created by Mitya Kim on 10/12/22.
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
        UIColor.green.cgColor,
        UIColor.red.cgColor,
        UIColor.blue.cgColor,
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
        
        gradientLayer.delegate = self
        
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Shape setup
        square = AnimationHelper.squareShapeLayer()
        circle = AnimationHelper.circleShapeLayer()
        view.layer.addSublayer(square)
        view.layer.addSublayer(circle)
        
        gradientAnimation()
        animateLineDash()
        animateCircleByPath()
        animateCircleShapeChange()
        createReplicatorLayer()
        createTextLayer()
        createCustomTransaction()
        
        segueToNextViewController(segueID: Constants.Segues.partyTimeVC, withDelay: 10.0)
    }
    
    func gradientAnimation() {
        let colorShift = CABasicAnimation(keyPath: AnimationHelper.gradientColors)
        colorShift.fromValue = colors
        colorShift.toValue = colors.reversed()
        colorShift.duration = 3
        colorShift.beginTime = AnimationHelper.addDelay(time: 1)
        colorShift.fillMode = CAMediaTimingFillMode.backwards
        colorShift.repeatCount = .infinity
        
        gradientLayer.colors = colors.reversed()
        gradientLayer.add(colorShift, forKey: "gradient_animation")
    }
    
    func animateLineDash() {
        let dash = CABasicAnimation(keyPath: AnimationHelper.dashPhase)
        
        dash.fromValue = 0
        dash.toValue = square.lineDashPattern?.reduce(0, { $0 + $1.intValue })
        dash.duration = 1.0
        dash.repeatCount = .infinity
        
        square.add(dash, forKey: "line_dash")
    }
    
    func animateCircleByPath() {
        let circleMovement = CAKeyframeAnimation(keyPath: AnimationHelper.position)
        circleMovement.repeatCount = .infinity
        circleMovement.duration = 3
        circleMovement.path = square.path
        circleMovement.calculationMode = CAAnimationCalculationMode.paced
        
        circle.add(circleMovement, forKey: "key_frame_path")
    }
    
    func animateCircleShapeChange() {
        let squish = CABasicAnimation(keyPath: AnimationHelper.shapePath)
        squish.duration = 1.5
        squish.repeatCount = .infinity
        squish.autoreverses = true
        squish.toValue = UIBezierPath(roundedRect: CGRect(x: -50, y: -50, width: 100, height: 100), cornerRadius: 0).cgPath
        
        circle.add(squish, forKey: "circle_squish")
    }
    
    func createReplicatorLayer() {
        let replicator = CAReplicatorLayer()
        
        replicator.frame = CGRect(x: 0, y: AnimationHelper.screenBounds.height - 100, width: AnimationHelper.screenBounds.width, height: 100)
        replicator.masksToBounds = true
        view.layer.addSublayer(replicator)
        
        triangle = AnimationHelper.triangleShapeLayer()
        replicator.addSublayer(triangle)
        
        replicator.instanceCount = 4
        replicator.instanceTransform = CATransform3DMakeTranslation(100, 0, 0)
        replicator.instanceDelay = TimeInterval(1)
        
//        let pulse = AnimationHelper.basicFadeAnimation()
//        pulse.autoreverses = true
//        pulse.repeatCount = .infinity
//
//        triangle.add(pulse, forKey: "fade_pulse")
    }
    
    func createTextLayer() {
        let titleLayer = CATextLayer()
        
        titleLayer.frame = CGRect(x: 0, y: 100, width: AnimationHelper.screenBounds.width, height: 100)
        titleLayer.string = "Cool Animation!"
        titleLayer.alignmentMode = .center
        view.layer.addSublayer(titleLayer)
        
        let textColor = CABasicAnimation(keyPath: AnimationHelper.textColor)
        textColor.duration = 1.5
        textColor.fromValue = UIColor.white.cgColor
        textColor.toValue = UIColor.brown.cgColor
        textColor.beginTime = AnimationHelper.addDelay(time: 2)
        textColor.fillMode = CAMediaTimingFillMode.backwards
        textColor.repeatCount = .infinity
        
        titleLayer.foregroundColor = UIColor.red.cgColor
        titleLayer.add(textColor, forKey: "text_color")
    }
    
    func createCustomTransaction() {
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(2.5)
        CATransaction.setCompletionBlock {
            print("Hello animation!")
        }
        
        let pulse = AnimationHelper.basicFadeAnimation()
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        
        triangle.add(pulse, forKey: "fade_pulse")
        
        CATransaction.commit()
    }

}

extension DashboardViewController: CALayerDelegate {
    func action(for layer: CALayer, forKey event: String) -> CAAction? {
//        switch event {
//        case kCAOnOrderIn:
//            return GradientColorAction()
//        case AnimationHelper.gradientLocations:
//            return GradientLocationAction()
//        default:
//            break
//        }
        return nil
    }
}
