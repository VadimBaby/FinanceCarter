//
//  AppCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import Domain

public protocol AppCoordinatorInput: Coordinator {
    func showPublicZone()
    func showPrivateZone(animated: Bool)
}

final class AppCoordinator: AppCoordinatorInput {
    private let window: UIWindow
    private let resolver: Resolver
    
    typealias PublicZoneFlowCoordinatorAssembly = (_ window: UIWindow, _ resolver: Resolver) -> PublicZoneFlowCoordinatorInput
    typealias PrivateZoneCoordinatorAssembly = (_ window: UIWindow, _ resolver: Resolver) -> PrivateZoneCoordinatorInput
    
    private let publicZoneFlowCoordinatorAssembly: PublicZoneFlowCoordinatorAssembly
    private let privateZoneCoordinatorAssembly: PrivateZoneCoordinatorAssembly
    
    private var publicZoneFlowCoordinator: PublicZoneFlowCoordinatorInput?
    private var privateZoneCoordinator: PrivateZoneCoordinatorInput?
    
    private let settingsStorage: SettingsStorageProtocol
    
    init(
        window: UIWindow,
        resolver: Resolver,
        settingsStorage: SettingsStorageProtocol,
        publicZoneFlowCoordinatorAssembly: @escaping PublicZoneFlowCoordinatorAssembly,
        privateZoneCoordinatorAssembly: @escaping PrivateZoneCoordinatorAssembly
    ) {
        self.window = window
        self.resolver = resolver
        self.publicZoneFlowCoordinatorAssembly = publicZoneFlowCoordinatorAssembly
        self.privateZoneCoordinatorAssembly = privateZoneCoordinatorAssembly
        self.settingsStorage = settingsStorage
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    public func start() {
        if settingsStorage.isPublicZoneCompleted {
            showPrivateZone()
        } else {
            showPublicZone()
        }
    }
}

extension AppCoordinator {
    public func showPrivateZone(animated: Bool = false) {
        privateZoneCoordinator = privateZoneCoordinatorAssembly(window, resolver)
        privateZoneCoordinator?.start(animated: animated)
        
        publicZoneFlowCoordinator = nil
    }
    
    public func showPublicZone() {
        publicZoneFlowCoordinator = publicZoneFlowCoordinatorAssembly(window, resolver)
        publicZoneFlowCoordinator?.delegate = self
        publicZoneFlowCoordinator?.start()
        
        privateZoneCoordinator = nil
    }
}

extension AppCoordinator: PublicZoneFlowCoordinatorOutput {
    func publicZoneDidFinish() {
        showPrivateZone(animated: true)
        settingsStorage.isPublicZoneCompleted = true
    }
}
