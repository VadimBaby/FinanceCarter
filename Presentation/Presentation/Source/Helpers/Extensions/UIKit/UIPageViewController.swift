//
//  UIPageViewController.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

extension UIPageViewController {
    func setViewControllers(
        _ viewControllers: [UIViewController],
        animated: Bool,
        disableUserInteractionDuringAnimation: Bool,
        completion passedCompletion: ((_ isFinished: Bool) -> Void)? = nil
    ) {
        var completion = passedCompletion
        
        if disableUserInteractionDuringAnimation {
            view.isUserInteractionEnabled = false
            
            completion = { [weak self] isFinished in
                passedCompletion?(isFinished)
                guard isFinished else { return }
                self?.view.isUserInteractionEnabled = true
            }
        }
        
        setViewControllers(viewControllers, direction: .forward, animated: animated, completion: completion)
    }
    
    func setViewController(
        _ viewController: UIViewController,
        animated: Bool,
        disableUserInteractionDuringAnimation: Bool,
        completion passedCompletion: ((_ isFinished: Bool) -> Void)? = nil
    ) {
        setViewControllers([viewController], animated: animated, disableUserInteractionDuringAnimation: disableUserInteractionDuringAnimation, completion: passedCompletion)
    }
}
