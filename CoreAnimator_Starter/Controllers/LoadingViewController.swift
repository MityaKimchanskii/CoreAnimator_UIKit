//
//  LoadingViewController.swift
//  CoreAnimator
//
//  Created by Mitya Kim on 10/12/22.
//

import UIKit

class LoadingViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var clockImage: UIImageView!
    @IBOutlet weak var setupLabel: UILabel!
    
    // Rotation values
    
    // MARK: Appearance
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clockImage.round(cornerRadius: clockImage.frame.size.width/2, borderWidth: 4, borderColor: UIColor.black)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let titleAnimationGroup = CAAnimationGroup()
        titleAnimationGroup.duration = 1.5
        titleAnimationGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        titleAnimationGroup.repeatCount = .infinity
        titleAnimationGroup.autoreverses = true
        titleAnimationGroup.animations = [positionPulse(), scalePulse()]
        
        loadingLabel.layer.add(titleAnimationGroup, forKey: "title_group")
        
        let clockAnimationGroup = CAAnimationGroup()
        clockAnimationGroup.repeatCount = .infinity
        clockAnimationGroup.duration = 3
        clockAnimationGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        
        clockAnimationGroup.animations = [
            createKeyFrameColorAnimation(),
            boundsKeyFrameAnimation(),
            rotateKeyFrame()
        ]
        
        clockImage.layer.add(clockAnimationGroup, forKey: "clock_group")
//        clockImage.layer.add(createKeyFrameColorAnimation(), forKey: "color_change")
//        clockImage.layer.position = CGPoint(x: AnimationHelper.screenBounds.width + 200, y: AnimationHelper.screenBounds.height - 250)
//        clockImage.layer.add(boundsKeyFrameAnimation(), forKey: "bounce")
        
        delayForSeconds(delay: 2) {
            self.animateViewTransition()
        }
        
        segueToNextViewController(segueID: Constants.Segues.dashboardVC, withDelay: 5.0)
    }
    
    func positionPulse() -> CABasicAnimation {
        let posY = CABasicAnimation(keyPath: AnimationHelper.posY)
        posY.fromValue = loadingLabel.layer.position.y - 20
        posY.toValue = loadingLabel.layer.position.y + 20
        
        return posY
    }
    
    func scalePulse() -> CABasicAnimation {
        let scale = CABasicAnimation(keyPath: AnimationHelper.scale)
        scale.fromValue = 1.1
        scale.toValue = 1.0
        
        return scale
    }
    
    // MARK: Keyframe Animations
    func createKeyFrameColorAnimation() -> CAKeyframeAnimation {
        let colorChange = CAKeyframeAnimation(keyPath: AnimationHelper.borderColor)
        colorChange.duration = 1
//        colorChange.beginTime = AnimationHelper.addDelay(time: 1.0)
        colorChange.repeatCount = .infinity
        colorChange.values = [
            UIColor.white.cgColor,
            UIColor.yellow.cgColor,
            UIColor.red.cgColor,
            UIColor.black.cgColor
        ]
        
        colorChange.keyTimes = [0.0, 0.25, 0.75, 1.0]
        
        return colorChange
    }
    
    func boundsKeyFrameAnimation() -> CAKeyframeAnimation {
        let bounce = CAKeyframeAnimation(keyPath: AnimationHelper.position)
        bounce.duration = 3.5
        bounce.values = [
            NSValue(cgPoint: CGPoint(x: 25, y: AnimationHelper.screenBounds.height - 100)),
            NSValue(cgPoint: CGPoint(x: 75, y: AnimationHelper.screenBounds.height - 150)),
            NSValue(cgPoint: CGPoint(x: 125, y: AnimationHelper.screenBounds.height - 100)),
            NSValue(cgPoint: CGPoint(x: 225, y: AnimationHelper.screenBounds.height - 150)),
            NSValue(cgPoint: CGPoint(x: 325, y: AnimationHelper.screenBounds.height - 100)),
            NSValue(cgPoint: CGPoint(x: AnimationHelper.screenBounds.width + 200, y: AnimationHelper.screenBounds.height - 250))
        ]
        
        bounce.keyTimes =  [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
        
        return bounce
    }
   
    func animateViewTransition() {
        let transition = CATransition()
        
        transition.duration = 1.5
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        
//        transition.startProgress = 0.4
//        transition.endProgress = 0.8
        
        loadingLabel.layer.add(transition, forKey: "reveal")
        setupLabel.layer.add(transition, forKey: "reveal")
        
        loadingLabel.isHidden = true
        setupLabel.isHidden = false
//        loadingLabel.alpha = 0
    }
    
    func rotateKeyFrame() -> CAKeyframeAnimation {
        let rotate = CAKeyframeAnimation(keyPath: AnimationHelper.rotation)
        
        rotate.values = [0.0, .pi/2.0, Double.pi * 3/2, Double.pi * 2]
        rotate.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        
        return rotate
    }
}

// MARK: Delegate Extensions
extension LoadingViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        //guard let animName = anim.value(forKey: "animation_name") as? String else { return }
    }
}
