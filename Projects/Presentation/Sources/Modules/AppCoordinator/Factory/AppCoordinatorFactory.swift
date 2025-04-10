//
//  AppCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import Domain

public final class AppCoordinatorFactory {
    private init() {}
    
    public static func create(window: UIWindow, resolver: Resolver) -> AppCoordinatorInput {
        AppCoordinator(
            window: window,
            resolver: resolver,
            settingsStorage: resolver.resolve(SettingsStorageProtocol.self)!,
            publicZoneFlowCoordinatorAssembly: PublicZoneFlowCoordinatorFactory.create,
            privateZoneCoordinatorAssembly: PrivateZoneCoordinatorFactory.create
        )
    }
}
