//
//  Coordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

public protocol Coordinator: AnyObject {
    func start()
}

protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get }
}

protocol TabBarItemCoordinator: NavigationCoordinator {
    var tabBarController: UIAppTabBarController { get }
}
