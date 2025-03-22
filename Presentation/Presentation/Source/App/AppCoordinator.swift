//
//  AppCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

public protocol AppCoordinatorInput: Coordinator {
    func showPublicZone()
    func showPrivateZone(animated: Bool)
}

final class AppCoordinator: AppCoordinatorInput {
    
    private let window: UIWindow
    private let resolver: Resolver
    
    private var publicZoneCoordinator: PublicZoneCoordinatorInput?
    private var privateZoneCoordinator: PrivateZoneCoordinatorInput?
    
    private let publicZoneCoordinatorAssembly: (_ window: UIWindow, _ resolver: Resolver) -> PublicZoneCoordinatorInput
    private let privateZoneCoordinatorAssembly: (_ window: UIWindow, _ resolver: Resolver) -> PrivateZoneCoordinatorInput
    
    init(
        window: UIWindow,
        resolver: Resolver,
        publicZoneCoordinatorAssembly: @escaping (_ window: UIWindow, _ resolver: Resolver) -> PublicZoneCoordinatorInput,
        privateZoneCoordinatorAssembly: @escaping (_ window: UIWindow, _ resolver: Resolver) -> PrivateZoneCoordinatorInput
    ) {
        self.window = window
        self.resolver = resolver
        self.publicZoneCoordinatorAssembly = publicZoneCoordinatorAssembly
        self.privateZoneCoordinatorAssembly = privateZoneCoordinatorAssembly
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    public func start() {
        showPublicZone()
    }
}

extension AppCoordinator {
    public func showPrivateZone(animated: Bool = false) {
        privateZoneCoordinator = privateZoneCoordinatorAssembly(window, resolver)
        privateZoneCoordinator?.start(animated: animated)
        
        publicZoneCoordinator = nil
    }
    
    public func showPublicZone() {
        publicZoneCoordinator = publicZoneCoordinatorAssembly(window, resolver)
        publicZoneCoordinator?.delegate = self
        publicZoneCoordinator?.start()
        
        privateZoneCoordinator = nil
    }
}

extension AppCoordinator: PublicZoneCoordinatorOutput {
    func publicZoneDidFinish() {
        showPrivateZone(animated: true)
    }
}
