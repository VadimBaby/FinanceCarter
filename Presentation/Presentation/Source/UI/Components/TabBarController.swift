//
//  TabBarController.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

protocol TabBarControllerProtocol: AnyObject {
    func setHomeViewController(_ viewController: UIViewController)
    func setProfileViewController(_ viewController: UIViewController)
}

final class TabBarController: UIAppTabBarController {
    func setHomeViewController(_ viewController: UIViewController) {
        viewController.tabBarItem = UITabBarItem(title: Strings.TabBar.home, image: .houseIcon, tag: 0)
        pushViewController(viewController)
    }
    
#warning("сделать один метод set(viewController: UIViewController, tabBar: TabBarItem)")
    func setProfileViewController(_ viewController: UIViewController) {
        viewController.tabBarItem = UITabBarItem(title: Strings.TabBar.profile, image: .personIcon, tag: 1)
        pushViewController(viewController)
    }
}
