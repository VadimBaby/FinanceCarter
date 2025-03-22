//
//  AppCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

public final class AppCoordinatorFactory {
    private init() {}
    
    public static func create(window: UIWindow, resolver: Resolver) -> AppCoordinatorInput {
        AppCoordinator(
            window: window,
            resolver: resolver,
            publicZoneCoordinatorAssembly: PublicZoneCoordinatorFactory.create,
            privateZoneCoordinatorAssembly: PrivateZoneCoordinatorFactory.create
        )
    }
}
