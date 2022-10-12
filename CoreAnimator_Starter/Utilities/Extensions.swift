//
//  Extensions.swift
//  CoreAnimator
//
//  Created by Mitya Kim on 9/13/22.
//

import UIKit

extension UIView {
    func round(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
    }
}

extension NSObject {
    public func delayForSeconds(delay: Double, completion: @escaping() -> ()) {
        let timer = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: timer) {
            completion()
        }
    }
}

extension UIViewController {
    func segueToNextViewController(segueID: String, withDelay: Double) {
        delayForSeconds(delay: withDelay) {
            self.performSegue(withIdentifier: segueID, sender: nil)
        }
    }
}
