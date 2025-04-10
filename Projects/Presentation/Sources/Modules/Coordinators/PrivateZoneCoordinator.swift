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
    
    typealias CoordinatorAssembly = (_ tabBarController: UIAppTabBarController, _ resolver: Resolver) -> TabBarItemCoordinator
    
    private let homeCoordinatorAssembly: CoordinatorAssembly
    private let categoriesCoordinatorAssembly: CoordinatorAssembly
    private let transactionsCoordinatorAssembly: CoordinatorAssembly
    private let walletsCoordinatorAssembly: CoordinatorAssembly
    private let profileCoordinatorAssembly: CoordinatorAssembly
    
    private var homeCoordinator: TabBarItemCoordinator?
    private var categoriesCoordinator: TabBarItemCoordinator?
    private var transactionsCoordinator: TabBarItemCoordinator?
    private var walletsCoordinator: TabBarItemCoordinator?
    private var profileCoordinator: TabBarItemCoordinator?
    
    init(
        window: UIWindow,
        resolver: Resolver,
        tabBarController: UIAppTabBarController = TabBarController(),
        homeCoordinatorAssembly: @escaping CoordinatorAssembly,
        categoriesCoordinatorAssembly: @escaping CoordinatorAssembly,
        transactionsCoordinatorAssembly: @escaping CoordinatorAssembly,
        walletsCoordinatorAssembly: @escaping CoordinatorAssembly,
        profileCoordinatorAssembly: @escaping CoordinatorAssembly
    ) {
        self.window = window
        self.resolver = resolver
        self.homeCoordinatorAssembly = homeCoordinatorAssembly
        self.categoriesCoordinatorAssembly = categoriesCoordinatorAssembly
        self.transactionsCoordinatorAssembly = transactionsCoordinatorAssembly
        self.walletsCoordinatorAssembly = walletsCoordinatorAssembly
        self.profileCoordinatorAssembly = profileCoordinatorAssembly
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
        homeCoordinator = homeCoordinatorAssembly(tabBarController, resolver)
        homeCoordinator?.start()
    }
    
    func setupCategoriesCoordinator() {
        categoriesCoordinator = categoriesCoordinatorAssembly(tabBarController, resolver)
        categoriesCoordinator?.start()
    }
    
    func setupTransactionsCoordinator() {
        transactionsCoordinator = transactionsCoordinatorAssembly(tabBarController, resolver)
        transactionsCoordinator?.start()
    }
    
    func setupWalletsCoordinator() {
        walletsCoordinator = walletsCoordinatorAssembly(tabBarController, resolver)
        walletsCoordinator?.start()
    }
    
    func setupProfileCoordinator() {
        profileCoordinator = profileCoordinatorAssembly(tabBarController, resolver)
        profileCoordinator?.start()
    }
}
