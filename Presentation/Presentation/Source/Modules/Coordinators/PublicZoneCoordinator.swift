//
//  PublicZoneCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import Domain

protocol PublicZoneCoordinatorOutput: AnyObject {
    func publicZoneDidFinish()
}

protocol PublicZoneCoordinatorInput: NavigationCoordinator {
    var delegate: PublicZoneCoordinatorOutput? { get set }
    
    func openOnboardingScreen()
    func openCredentialsScreen()
}

final class PublicZoneCoordinator: PublicZoneCoordinatorInput {
    var navigationController: UINavigationController
    weak var delegate: PublicZoneCoordinatorOutput?
    
    private let window: UIWindow
    private let resolver: Resolver
    private let keyValueStorage: KeyValueStorageRepository
    
    private let onboardingViewAssembly: (_ coordinator: OnboardingPresenterOutput, _ resolver: Resolver) -> OnboardingViewInput & UIViewController
    private let credentialsViewAssembly: (_ coordinator: CredentialPresenterOutput, _ resolver: Resolver) -> CredentialViewInput & UIViewController
    
    init(
        window: UIWindow,
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        keyValueStorage: KeyValueStorageRepository,
        onboardingViewAssembly: @escaping (_ coordinator: OnboardingPresenterOutput, _ resolver: Resolver) -> OnboardingViewInput & UIViewController,
        credentialsViewAssembly: @escaping (_ coordinator: CredentialPresenterOutput, _ resolver: Resolver) -> CredentialViewInput & UIViewController
    ) {
        self.window = window
        self.resolver = resolver
        self.keyValueStorage = keyValueStorage
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        self.onboardingViewAssembly = onboardingViewAssembly
        self.credentialsViewAssembly = credentialsViewAssembly
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func start() {
        defer { window.rootViewController = navigationController }
        
        if keyValueStorage.isOnboardingCompleted {
            openCredentialsScreen()
        } else {
            openOnboardingScreen()
        }
    }
    
    func openOnboardingScreen() {
        let view = onboardingViewAssembly(self, resolver)
        navigationController.pushViewController(view, animated: true)
    }
    
    func openCredentialsScreen() {
        let view = credentialsViewAssembly(self, resolver)
        navigationController.pushViewController(view, animated: true)
    }
}

// MARK: - OnboardingPresenterOutput

extension PublicZoneCoordinator: OnboardingPresenterOutput {
    func onboardingDidFinish() {
        openCredentialsScreen()
    }
}

// MARK: - CredentialPresenterOutput

extension PublicZoneCoordinator: CredentialPresenterOutput {
    func didTapNext() {
        delegate?.publicZoneDidFinish()
    }
}

