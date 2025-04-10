//
//  ProfileFlowCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

final class ProfileFlowCoordinatorFactory {
    private init() {}
    
    static func create(resolver: Resolver) -> ProfileFlowCoordinatorInput {
        ProfileFlowCoordinator(
            resolver: resolver,
            profileRouterAssembly: ProfileAssembly.router
        )
    }
}
