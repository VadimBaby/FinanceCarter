//
//  CategoriesFlowCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

final class CategoriesFlowCoordinatorFactory {
    private init() {}
    
    static func create(resolver: Resolver) -> CategoriesFlowCoordinatorInput {
        CategoriesFlowCoordinator(
            resolver: resolver,
            categoriesRouterAssembly: CategoriesAssembly.router
        )
    }
}
