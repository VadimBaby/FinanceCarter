//
//  UIWindow.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

extension UIWindow {
    func setRootViewController(
        _ newRootViewController: UIViewController,
        animated: Bool = true,
        duration: TimeInterval = 0.3,
        completion: (() -> Void)? = nil
    ) {
        guard animated else {
            rootViewController = newRootViewController
            completion?()
            return
        }
    
        guard let snapshot = snapshotView(afterScreenUpdates: false) else {
            rootViewController = newRootViewController
            completion?()
            return
        }
    
        addSubview(snapshot)
    
        rootViewController = newRootViewController
        newRootViewController.view.transform = CGAffineTransform(translationX: frame.width, y: 0)
        
        UIView.animate(withDuration: duration, animations: {
            snapshot.transform = CGAffineTransform(translationX: -self.frame.width, y: 0)
            newRootViewController.view.transform = .identity
        }, completion: { _ in
            snapshot.removeFromSuperview()
            completion?()
        })
    }
}
