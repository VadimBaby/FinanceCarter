//
//  TransactionsCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

final class TransactionsCoordinatorFactory {
    private init() {}
    
    static func create(tabBarController: UIAppTabBarController, resolver: Resolver) -> TabBarItemCoordinator {
        return TransactionsCoordinator(
            tabBarController: tabBarController,
            resolver: resolver,
            transactionsAssembly: TransactionsModuleFactory.create
        )
    }
}
