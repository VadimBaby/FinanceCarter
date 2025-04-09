//
//  HomeCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

final class HomeCoordinator: TabBarItemCoordinator {
    private let resolver: Resolver
    
    let navigationController: UINavigationController
    let tabBarController: UIAppTabBarController
    
    private let homeAssembly: (_ coordinator: HomePresenterOutput, _ resolver: Resolver) -> UIViewController & HomeViewInput
    
    init(
        tabBarController: UIAppTabBarController,
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        homeAssembly: @escaping (_ coordinator: HomePresenterOutput, _ resolver: Resolver) -> UIViewController & HomeViewInput
    ) {
        self.tabBarController = tabBarController
        self.homeAssembly = homeAssembly
        
        self.resolver = resolver
        
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func start() {
        let view = homeAssembly(self, resolver)
        
        navigationController.setRootViewController(view)
        tabBarController.setTab(viewController: navigationController, for: .home)
    }
}

extension HomeCoordinator: HomePresenterOutput {
    
}
