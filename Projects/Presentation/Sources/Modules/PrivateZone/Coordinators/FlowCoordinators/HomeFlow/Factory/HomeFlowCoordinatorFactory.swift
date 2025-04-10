//
//  HomeFlowCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

final class HomeFlowCoordinatorFactory {
    private init() {}
    
    static func create(resolver: Resolver) -> HomeFlowCoordinatorInput {
        HomeFlowCoordinator(
            resolver: resolver,
            homeRouterAssembly: HomeAssembly.router
        )
    }
}
