//
//  PublicZoneCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import Domain

protocol PublicZoneFlowCoordinatorOutput: AnyObject {
    func publicZoneDidFinish()
}

protocol PublicZoneFlowCoordinatorInput: NavigationCoordinator {
    var delegate: PublicZoneFlowCoordinatorOutput? { get set }
    
    func openOnboardingScreen()
    func openCredentialsScreen()
}

final class PublicZoneFlowCoordinator: PublicZoneFlowCoordinatorInput {
    var navigationController: UINavigationController
    weak var delegate: PublicZoneFlowCoordinatorOutput?
    
    private let window: UIWindow
    private let resolver: Resolver
    private let settingsStorage: SettingsStorageProtocol
    
    typealias OnboardingRouterAssembly = (_ navigationController: UINavigationController, _ resolver: Resolver) -> OnboardingRouterInput
    typealias CredentialRouterAssembly = (_ navigationController: UINavigationController, _ resolver: Resolver) -> CredentialRouterInput
    
    private let onboardingRouterAssembly: OnboardingRouterAssembly
    private let credentialRouterAssembly: CredentialRouterAssembly
    
    private var onboardingRouter: OnboardingRouterInput?
    private var credentialRouter: CredentialRouterInput?
    
    init(
        window: UIWindow,
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        settingsStorage: SettingsStorageProtocol,
        onboardingRouterAssembly: @escaping OnboardingRouterAssembly,
        credentialRouterAssembly: @escaping CredentialRouterAssembly
    ) {
        self.window = window
        self.resolver = resolver
        self.settingsStorage = settingsStorage
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        self.onboardingRouterAssembly = onboardingRouterAssembly
        self.credentialRouterAssembly = credentialRouterAssembly
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func start() {
        defer { window.rootViewController = navigationController }
        
        if !settingsStorage.isOnboardingCompleted {
            openOnboardingScreen()
        } else if settingsStorage.userName == .empty {
            openCredentialsScreen()
        } else {
            fatalError("It's nothing to show in PublicZone")
        }
    }

    func openOnboardingScreen() {
        onboardingRouter = onboardingRouterAssembly(navigationController, resolver)
        onboardingRouter?.delegate = self
        onboardingRouter?.open()
    }
    
    func openCredentialsScreen() {
        credentialRouter = credentialRouterAssembly(navigationController, resolver)
        credentialRouter?.delegate = self
        credentialRouter?.open()
    }
}

// MARK: - OnboardingPresenterOutput

extension PublicZoneFlowCoordinator: OnboardingRouterOutput {
    func onboardingDidFinish() {
        openCredentialsScreen()
    }
}

// MARK: - CredentialPresenterOutput

extension PublicZoneFlowCoordinator: CredentialRouterOutput {
    func credentialDidFinish() {
        delegate?.publicZoneDidFinish()
    }
}
