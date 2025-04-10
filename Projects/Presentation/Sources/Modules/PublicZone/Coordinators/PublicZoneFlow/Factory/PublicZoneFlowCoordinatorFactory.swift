//
//  PublicZoneCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import Domain

final class PublicZoneFlowCoordinatorFactory {
    private init() {}
    
    static func create(window: UIWindow, resolver: Resolver) -> PublicZoneFlowCoordinatorInput {
        PublicZoneFlowCoordinator(
            window: window,
            resolver: resolver,
            settingsStorage: resolver.resolve(SettingsStorageProtocol.self)!,
            onboardingRouterAssembly: OnboardingAssembly.router,
            credentialRouterAssembly: CredentialAssembly.router
        )
    }
}
