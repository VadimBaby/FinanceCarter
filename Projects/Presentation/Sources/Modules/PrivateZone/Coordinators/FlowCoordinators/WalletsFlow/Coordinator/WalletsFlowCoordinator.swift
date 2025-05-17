//
//  WalletsFlowCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Common

protocol WalletsFlowCoordinatorOutput: AnyObject {
    func walletsFlowCoordinatorDidStart(with viewController: UIViewController)
}

protocol WalletsFlowCoordinatorInput: NavigationCoordinator {
    var delegate: WalletsFlowCoordinatorOutput? { get set }
}

final class WalletsFlowCoordinator: WalletsFlowCoordinatorInput {
    weak var delegate: WalletsFlowCoordinatorOutput?
    
    private let resolver: Resolver
    
    let navigationController: UINavigationController
    
    typealias WalletsRouterAssembly = (_ navigationController: UINavigationController, _ resolver: Resolver) -> WalletsRouterInput
    typealias CreateWalletRouterAssembly = (_ navigationController: UINavigationController, _ resolver: Resolver) -> CreateWalletRouterInput
    
    private let walletsRouterAssembly: WalletsRouterAssembly
    private let createWalletRouterAssembly: CreateWalletRouterAssembly
    
    private var walletsRouter: WalletsRouterInput?
    private var createWalletRouter: CreateWalletRouterInput?
    
    init(
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        walletsRouterAssembly: @escaping WalletsRouterAssembly,
        createWalletRouterAssembly: @escaping CreateWalletRouterAssembly
    ) {
        self.walletsRouterAssembly = walletsRouterAssembly
        self.createWalletRouterAssembly = createWalletRouterAssembly
        
        self.resolver = resolver
        
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        print("\(Self.self) init")
    }
    
    private var updateWalletsViewClosure: VoidAction? = nil
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func start() {
        defer { delegate?.walletsFlowCoordinatorDidStart(with: navigationController) }
        openWalletsScreen()
    }
}

// MARK: - Private Methods

private extension WalletsFlowCoordinator {
    func openWalletsScreen() {
        walletsRouter = walletsRouterAssembly(navigationController, resolver)
        walletsRouter?.delegate = self
        walletsRouter?.open()
    }
    
    func openCreateWalletScreen() {
        createWalletRouter = createWalletRouterAssembly(navigationController, resolver)
        createWalletRouter?.delegate = self
        createWalletRouter?.open()
    }
    
    func closeCreateWalletScreen() {
        createWalletRouter?.close()
        createWalletRouter = nil
        updateWalletsViewClosure = nil
    }
}

// MARK: - WalletsRouterOutput

extension WalletsFlowCoordinator: WalletsRouterOutput {
    func walletsAddButtonDidTap(updateWalletsViewClosure: @escaping VoidAction) {
        self.updateWalletsViewClosure = updateWalletsViewClosure
        openCreateWalletScreen()
    }
}

// MARK: - CreateWalletsRouterOutput

extension WalletsFlowCoordinator: CreateWalletRouterOutput {
    func closeButtonDidPressed() {
        closeCreateWalletScreen()
    }
    
    func walletDidAdded() {
        self.updateWalletsViewClosure?()
        closeCreateWalletScreen()
    }
}
