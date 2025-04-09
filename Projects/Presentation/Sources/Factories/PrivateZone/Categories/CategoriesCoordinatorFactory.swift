//
//  CategoriesCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

final class CategoriesCoordinatorFactory {
    private init() {}
    
    static func create(tabBarController: UIAppTabBarController, resolver: Resolver) -> TabBarItemCoordinator {
        CategoriesCoordinator(
            tabBarController: tabBarController,
            resolver: resolver,
            categoriesAssembly: CategoriesModuleFactory.create
        )
    }
}
