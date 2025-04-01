//
//  HomeCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

final class HomeCoordinatorFactory {
    private init() {}
    
    static func create(tabBarController: UIAppTabBarController, resolver: Resolver) -> TabBarItemCoordinator {
        HomeCoordinator(tabBarController: tabBarController, resolver: resolver, homeAssembly: HomeModuleFactory.create)
    }
}
