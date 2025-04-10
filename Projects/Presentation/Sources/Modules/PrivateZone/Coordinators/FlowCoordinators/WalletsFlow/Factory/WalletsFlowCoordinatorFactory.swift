//
//  WalletsFlowCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

final class WalletsFlowCoordinatorFactory {
    private init() {}
    
    static func create(resolver: Resolver) -> WalletsFlowCoordinatorInput {
        WalletsFlowCoordinator(
            resolver: resolver,
            walletsRouterAssembly: WalletsAssembly.router
        )
    }
}
