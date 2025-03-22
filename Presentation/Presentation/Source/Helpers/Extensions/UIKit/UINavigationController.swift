//
//  UINavigationController.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

extension UINavigationController {
    func setRootViewController(_ viewController: UIViewController) {
        setViewControllers([viewController], animated: false)
    }
}
