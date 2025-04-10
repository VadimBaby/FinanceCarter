//
//  CategoriesCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

final class CategoriesRouter: TabBarItemCoordinator {
    private let resolver: Resolver
    
    let navigationController: UINavigationController
    let tabBarController: UIAppTabBarController
    
    typealias CategoriesAssembly = (_ coordinator: CategoriesPresenterOutput, _ resolver: Resolver) -> CategoriesViewInput & UIViewController
    
    private let categoriesAssembly: CategoriesAssembly
    
    init(
        tabBarController: UIAppTabBarController,
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        categoriesAssembly: @escaping CategoriesAssembly
    ) {
        self.tabBarController = tabBarController
        self.categoriesAssembly = categoriesAssembly
        
        self.resolver = resolver
        
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        let view = categoriesAssembly(self, resolver)
        
        navigationController.setRootViewController(view)
        tabBarController.setTab(viewController: navigationController, for: .categories)
    }
}

extension CategoriesRouter: CategoriesPresenterOutput {
    
}
