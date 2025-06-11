//
//  PrivateZoneCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

protocol PrivateZoneCoordinatorInput: Coordinator {
    var tabBarController: UIAppTabBarController { get }
    
    func start(animated: Bool)
}

final class PrivateZoneCoordinator: PrivateZoneCoordinatorInput {
    let tabBarController: UIAppTabBarController
    
    private let window: UIWindow
    private let resolver: Resolver
    
    typealias HomeFlowCoordinatorAssembly = (_ resolver: Resolver) -> HomeFlowCoordinatorInput
    typealias ProfileFlowCoordinatorAssembly = (_ resolver: Resolver) -> ProfileFlowCoordinatorInput
    typealias WalletsFlowCoordinatorAssembly = (_ resolver: Resolver) -> WalletsFlowCoordinatorInput
    typealias TransactionsFlowCoordinatorAssembly = (_ resolver: Resolver) -> TransactionsFlowCoordinatorInput
    typealias CategoriesFlowCoordinatorAssembly = (_ resolver: Resolver) -> CategoriesFlowCoordinatorInput
    
    private let homeFlowCoordinatorAssembly: HomeFlowCoordinatorAssembly
    private let categoriesFlowCoordinatorAssembly: CategoriesFlowCoordinatorAssembly
    private let transactionsFlowCoordinatorAssembly: TransactionsFlowCoordinatorAssembly
    private let walletsFlowCoordinatorAssembly: WalletsFlowCoordinatorAssembly
    private let profileFlowCoordinatorAssembly: ProfileFlowCoordinatorAssembly
    
    private var homeFlowCoordinator: HomeFlowCoordinatorInput?
    private var categoriesFlowCoordinator: CategoriesFlowCoordinatorInput?
    private var transactionsFlowCoordinator: TransactionsFlowCoordinatorInput?
    private var walletsFlowCoordinator: WalletsFlowCoordinatorInput?
    private var profileFlowCoordinator: ProfileFlowCoordinatorInput?
    
    init(
        window: UIWindow,
        resolver: Resolver,
        tabBarController: UIAppTabBarController = TabBarController(),
        homeFlowCoordinatorAssembly: @escaping HomeFlowCoordinatorAssembly,
        categoriesFlowCoordinatorAssembly: @escaping CategoriesFlowCoordinatorAssembly,
        transactionsFlowCoordinatorAssembly: @escaping TransactionsFlowCoordinatorAssembly,
        walletsFlowCoordinatorAssembly: @escaping WalletsFlowCoordinatorAssembly,
        profileFlowCoordinatorAssembly: @escaping ProfileFlowCoordinatorAssembly
    ) {
        self.window = window
        self.resolver = resolver
        self.homeFlowCoordinatorAssembly = homeFlowCoordinatorAssembly
        self.categoriesFlowCoordinatorAssembly = categoriesFlowCoordinatorAssembly
        self.transactionsFlowCoordinatorAssembly = transactionsFlowCoordinatorAssembly
        self.walletsFlowCoordinatorAssembly = walletsFlowCoordinatorAssembly
        self.profileFlowCoordinatorAssembly = profileFlowCoordinatorAssembly
        self.tabBarController = tabBarController
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func start() {
        start(animated: false)
    }
    
    func start(animated: Bool) {
        setupHomeCoordinator()
        setupCategoriesCoordinator()
        setupTransactionsCoordinator()
        setupWalletsCoordinator()
        setupProfileCoordinator()
        
        window.setRootViewController(tabBarController, animated: animated)
    }
}

// MARK: Private Methods

private extension PrivateZoneCoordinator {
    func setupHomeCoordinator() {
        homeFlowCoordinator = homeFlowCoordinatorAssembly(resolver)
        homeFlowCoordinator?.delegate = self
        homeFlowCoordinator?.start()
    }
    
    func setupCategoriesCoordinator() {
        categoriesFlowCoordinator = categoriesFlowCoordinatorAssembly(resolver)
        categoriesFlowCoordinator?.delegate = self
        categoriesFlowCoordinator?.start()
    }
    
    func setupTransactionsCoordinator() {
        transactionsFlowCoordinator = transactionsFlowCoordinatorAssembly(resolver)
        transactionsFlowCoordinator?.delegate = self
        transactionsFlowCoordinator?.start()
    }
    
    func setupWalletsCoordinator() {
        walletsFlowCoordinator = walletsFlowCoordinatorAssembly(resolver)
        walletsFlowCoordinator?.delegate = self
        walletsFlowCoordinator?.start()
    }
    
    func setupProfileCoordinator() {
        profileFlowCoordinator = profileFlowCoordinatorAssembly(resolver)
        profileFlowCoordinator?.delegate = self
        profileFlowCoordinator?.start()
    }
}

// MARK: - HomeFlowCoordinatorOutput

extension PrivateZoneCoordinator: HomeFlowCoordinatorOutput {
    func homeFlowCoordinatorDidStart(with viewController: UIViewController) {
       // tabBarController.setTab(viewController: viewController, for: .home)
    }
}

// MARK: - ProfileFlowCoordinatorOutput

extension PrivateZoneCoordinator: ProfileFlowCoordinatorOutput {
    func profileFlowCoordinatorDidStart(with viewController: UIViewController) {
       // tabBarController.setTab(viewController: viewController, for: .profile)
    }
}

// MARK: - WalletsFlowCoordinatorOutput

extension PrivateZoneCoordinator: WalletsFlowCoordinatorOutput {
    func walletsFlowCoordinatorDidStart(with viewController: UIViewController) {
        tabBarController.setTab(viewController: viewController, for: .wallets)
    }
}

// MARK: - TransactionsFlowCoordinatorOutput

extension PrivateZoneCoordinator: TransactionsFlowCoordinatorOutput {
    func transactionsFlowCoordinatorDidStart(with viewController: UIViewController) {
        tabBarController.setTab(viewController: viewController, for: .transactions)
    }
    
    func transactionsFlowCoordinatorTransactionDidAdded() {
        walletsFlowCoordinator?.updateWalletsView()
    }
}

// MARK: - CategoriesFlowCoordinatorOutput

extension PrivateZoneCoordinator: CategoriesFlowCoordinatorOutput {
    func categoriesFlowCoordinatorDidStart(with viewController: UIViewController) {
        tabBarController.setTab(viewController: viewController, for: .categories)
    }
}
