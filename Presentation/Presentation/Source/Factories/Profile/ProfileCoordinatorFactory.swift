//
//  ProfileCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

final class ProfileCoordinatorFactory {
    private init() {}
    
    static func create(tabBarController: UIAppTabBarController, resolver: Resolver) -> TabBarItemCoordinator {
        ProfileCoordinator(tabBarController: tabBarController, resolver: resolver, profileAssembly: ProfileModuleFactory.create)
    }
}
