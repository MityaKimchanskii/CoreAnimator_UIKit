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
        partyLabel.frame = CGRect(x: AnimationHelper.screenBounds.midX - 150, y: 100, width: 150, height: 50)
        partyLabel.text = "Party"
        partyLabel.font = UIFont(name: "Arial-Bold", size: 20)
        partyLabel.textColor = UIColor.white
        partyLabel.textAlignment = .center
        partyLabel.layer.borderColor = UIColor.white.cgColor
        partyLabel.layer.borderWidth = 3.0
        
        timeLabel = UILabel()
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
        celebrateLabel.font = UIFont(name: "Arial", size: 25)
        celebrateLabel.textColor = UIColor.white
        celebrateLabel.textAlignment = .center
        
        view.addSubview(partyLabel)
        view.addSubview(timeLabel)
        view.addSubview(celebrateLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: 3D Animations
    
    // MARK: Particle Emitter
}
