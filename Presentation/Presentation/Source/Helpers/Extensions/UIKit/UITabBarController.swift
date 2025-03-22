//
//  UITabBarController.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

extension UITabBarController {
    func pushViewController(_ viewController: UIViewController) {
        self.viewControllers = (self.viewControllers ?? []) + [viewController]
    }
}

