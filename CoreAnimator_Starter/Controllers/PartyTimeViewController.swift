//
//  PartyTimeViewController.swift
//  CoreAnimator
//
//  Created by Mitya Kim on 10/12/22.
//

import UIKit

class PartyTimeViewController: UIViewController {
    
    // Labels
    var partyLabel: UILabel!
    var timeLabel: UILabel!
    var celebrateLabel: UILabel!
    
    // MARK: Appearance
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        partyLabel = UILabel()
        partyLabel.layer.anchorPoint.x = 1.0
        partyLabel.frame = CGRect(x: AnimationHelper.screenBounds.midX - 150, y: 100, width: 150, height: 50)
        partyLabel.text = "Party"
        partyLabel.font = UIFont(name: "Arial-Bold", size: 20)
        partyLabel.textColor = UIColor.white
        partyLabel.textAlignment = .center
        partyLabel.layer.borderColor = UIColor.white.cgColor
        partyLabel.layer.borderWidth = 3.0
        
        timeLabel = UILabel()
        timeLabel.layer.anchorPoint.x = 0.0
        timeLabel.frame = CGRect(x: AnimationHelper.screenBounds.midX, y: 100, width: 150, height: 50)
        timeLabel.text = "Time"
        timeLabel.font = UIFont(name: "Arial-Bold", size: 20)
        timeLabel.textColor = UIColor.white
        timeLabel.textAlignment = .center
        timeLabel.layer.borderColor = UIColor.white.cgColor
        timeLabel.layer.borderWidth = 3.0
        
        celebrateLabel = UILabel()
        celebrateLabel.frame = CGRect(x: AnimationHelper.screenBounds.midX - 75, y: AnimationHelper.screenBounds.midY, width: 150, height: 150)
        celebrateLabel.text = "CELEBRATE!"
        celebrateLabel.font = UIFont(name: "Arial", size: 20)
        celebrateLabel.textColor = UIColor.white
        celebrateLabel.textAlignment = .center
        celebrateLabel.layer.borderColor = UIColor.white.cgColor
        celebrateLabel.layer.borderWidth = 3.0
        
        view.addSubview(partyLabel)
        view.addSubview(timeLabel)
        view.addSubview(celebrateLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        positionLabel()
        animateLabel3D()
        createFireworkEmitter()
//        view.layer.sublayerTransform = create3DPerspectiveTransform(cameraDistance: 500)
        celebrateLabel.layer.transform = create3DMultyTransform()
    }
    
    // MARK: 3D Animations
    func create3DPerspectiveTransform(cameraDistance: CGFloat) -> CATransform3D {
        var viewPerspective = CATransform3DIdentity
        viewPerspective.m34 = -1.0/cameraDistance
        
        return viewPerspective
    }
    
    func positionLabel() {
        let rotAngle = CGFloat.pi/4.0
        var rotTransform = create3DPerspectiveTransform(cameraDistance: 800)
        
        rotTransform = CATransform3DRotate(rotTransform, rotAngle, 0.0, 1.0, 0.0)
        partyLabel.layer.transform = rotTransform
    }
    
    
    func create3DMultyTransform() -> CATransform3D {
        var multyTransform = create3DPerspectiveTransform(cameraDistance: 1000)
        multyTransform = CATransform3DTranslate(multyTransform, 0.0, 150, 200)
        multyTransform = CATransform3DRotate(multyTransform, .pi/2.5, 1.0, 0.0, 0.0)
        multyTransform = CATransform3DScale(multyTransform, 1.7, 1.3, 1.0)
        
        return multyTransform
    }
    
    func animateLabel3D() {
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {
            self.partyLabel.layer.shouldRasterize = false
            print("Rasterizing off...")
        }
        
        var perspectiveTransform = create3DPerspectiveTransform(cameraDistance: 800)
        perspectiveTransform = CATransform3DRotate(perspectiveTransform, .pi/4.0, 0.0, -1.0, 0.0)
        
        let rotate3D = CABasicAnimation(keyPath: AnimationHelper.transform)
        rotate3D.duration = 2.0
        rotate3D.fromValue = timeLabel.layer.transform
        rotate3D.toValue = perspectiveTransform
        rotate3D.beginTime = AnimationHelper.addDelay(time: 1.0)
        rotate3D.fillMode = CAMediaTimingFillMode.backwards
        
        partyLabel.layer.shouldRasterize = true
        partyLabel.layer.rasterizationScale = UIScreen.main.scale
        print("Rasterizing on...")
        
        timeLabel.layer.transform = perspectiveTransform
        timeLabel.layer.add(rotate3D, forKey: "rotate_3D")
        
        CATransaction.commit()
    }
    
    func createFireworkEmitter() {
        let fireworkEmitter = CAEmitterLayer()
        fireworkEmitter.frame = view.bounds
        fireworkEmitter.emitterPosition = CGPoint(x: AnimationHelper.screenBounds.midX, y: AnimationHelper.screenBounds.midY)
        fireworkEmitter.emitterSize = CGSize(width: 150, height: 150)
        fireworkEmitter.emitterShape = CAEmitterLayerEmitterShape.point
        
        fireworkEmitter.emitterCells = [
            createFirework(colorFire: UIColor.green),
            createFirework(colorFire: UIColor.blue),
            createFirework(colorFire: UIColor.orange),
            createFirework(colorFire: UIColor.purple),
            createFirework(colorFire: UIColor.systemPink)
        ]
        
        view.layer.addSublayer(fireworkEmitter)
    }
    
    func createFirework(colorFire: UIColor) -> CAEmitterCell {
        let firework = CAEmitterCell()
        
        firework.contents = UIImage(named: "firework.png")?.cgImage
        firework.birthRate = 1.5
        firework.lifetime = 1.5
        firework.yAcceleration = 100
        firework.xAcceleration = 15
        firework.velocity = 50
        firework.velocityRange = 100
        firework.emissionLongitude = -.pi/2
        firework.emissionLatitude = .pi/2
        firework.emissionRange = .pi/2
        firework.scale = 0.8
        firework.scaleRange = 0.1
        firework.scaleSpeed = -0.1
        firework.alphaRange = 0.7
        firework.alphaSpeed = -0.15
        firework.color = colorFire.cgColor
        
        
        return firework
    }
    
}
