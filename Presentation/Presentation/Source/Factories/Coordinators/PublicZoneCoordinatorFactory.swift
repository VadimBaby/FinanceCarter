//
//  PublicZoneCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import Domain

final class PublicZoneCoordinatorFactory {
    private init() {}
    
    static func create(window: UIWindow, resolver: Resolver) -> PublicZoneCoordinatorInput {
        PublicZoneCoordinator(
            window: window,
            resolver: resolver,
            keyValueStorage: resolver.resolve(KeyValueStorageRepository.self)!,
            onboardingViewAssembly: OnboardingModuleFactory.create,
            credentialsViewAssembly: CredentialModuleFactory.create
        )
    }
}

