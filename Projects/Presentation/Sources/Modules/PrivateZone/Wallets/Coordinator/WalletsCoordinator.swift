//
//  WalletsCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

final class WalletsCoordinator: TabBarItemCoordinator {
    private let resolver: Resolver
    
    let navigationController: UINavigationController
    let tabBarController: UIAppTabBarController
    
    typealias WalletsAssembly = (_ coordinator: WalletsPresenterOutput, _ resolver: Resolver) -> WalletsViewInput & UIViewController
    
    private let walletsAssembly: WalletsAssembly
    
    init(
        tabBarController: UIAppTabBarController,
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        walletsAssembly: @escaping WalletsAssembly
    ) {
        self.tabBarController = tabBarController
        self.walletsAssembly = walletsAssembly
        
        self.resolver = resolver
        
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func start() {
        let view = walletsAssembly(self, resolver)
        
        navigationController.setRootViewController(view)
        tabBarController.setTab(viewController: navigationController, for: .wallets)
    }
}

extension WalletsCoordinator: WalletsPresenterOutput {
    
}
