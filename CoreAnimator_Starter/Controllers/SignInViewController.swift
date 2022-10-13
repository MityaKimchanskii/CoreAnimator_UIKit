//
//  ViewController.swift
//  CoreAnimator
//
//  Created by Mitya Kim on 10/12/22.
//

import UIKit

class SignInViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    // MARK: Appearance
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        signInButton.round(cornerRadius: 10, borderWidth: 3, borderColor: UIColor.white)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        signInButton.layer.position.y += AnimationHelper.screenBounds.height
        fadeInViews()
        animateButton()
        animateBorderColorPulse()
    }
    
    // MARK: User Actions
    @IBAction func SignInOnButtonPressed(_ sender: Any) {
        animateButtonPressed()
        segueToNextViewController(segueID: Constants.Segues.loadingVC, withDelay: 1.0)
    }
    
    // MARK: Animations
    func fadeInViews() {
        let fade = AnimationHelper.basicFadeAnimation()
//        fade.delegate = self
        titleLabel.layer.add(fade, forKey: nil)
        
        fade.beginTime = AnimationHelper.addDelay(time: 1)
        usernameField.layer.add(fade, forKey: nil)
        
        fade.beginTime = AnimationHelper.addDelay(time: 2)
        fade.setValue("password", forKey: "animation_name")
        passwordField.layer.add(fade, forKey: nil)
    }
    
    func animateButton() {
        let moveUp = CASpringAnimation(keyPath: AnimationHelper.posY)
        

        moveUp.fromValue = signInButton.layer.position.y + AnimationHelper.screenBounds.height
        moveUp.toValue = signInButton.layer.position.y
//        moveUp.toValue = signInButton.layer.position.y - AnimationHelper.screenBounds.height
        moveUp.duration = moveUp.settlingDuration
        moveUp.beginTime = AnimationHelper.addDelay(time: 2.5)
        moveUp.fillMode = CAMediaTimingFillMode.backwards
        
        moveUp.initialVelocity = 5
        moveUp.mass = 1
        moveUp.stiffness = 75
        moveUp.damping = 12
        
//        signInButton.layer.position.y -= AnimationHelper.screenBounds.height
        signInButton.layer.add(moveUp, forKey: nil)
    }
    
    func animateBorderColorPulse() {
        let colorFade = CABasicAnimation(keyPath: AnimationHelper.borderColor)
        colorFade.fromValue = UIColor.red.cgColor
        colorFade.toValue = UIColor.white.cgColor
        colorFade.duration = 1
        colorFade.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        colorFade.speed = 1
        colorFade.repeatCount = .infinity
        colorFade.autoreverses = true
        
        signInButton.layer.add(colorFade, forKey: nil)
    }
    
    func animateButtonPressed() {
        let pop = CASpringAnimation(keyPath: AnimationHelper.scale)
        
        pop.fromValue = 1.2
        pop.toValue = 1
        pop.duration = pop.settlingDuration
        pop.initialVelocity = 2
        pop.damping = 10
        
        signInButton.layer.add(pop, forKey: "pop")
    }
}

//// MARK: Delegate Extensions
//extension SignInViewController: CAAnimationDelegate {
//    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//        guard let animName = anim.value(forKey: "animation_name") as? String else { return }
//
//        switch animName {
//        case "password":
//            animateButton()
//        default:
//            break
//        }
//    }
//}
