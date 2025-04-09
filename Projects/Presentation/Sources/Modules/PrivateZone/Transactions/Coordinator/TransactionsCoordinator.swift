//
//  TransactionsCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

final class TransactionsCoordinator: TabBarItemCoordinator {
    private let resolver: Resolver
    
    let navigationController: UINavigationController
    let tabBarController: UIAppTabBarController
    
    typealias TransactionsAssembly = (_ coordinator: TransactionsPresenterOutput, _ resolver: Resolver) -> TransactionsViewInput & UIViewController
    
    private let transactionsAssembly: TransactionsAssembly
    
    init(
        tabBarController: UIAppTabBarController,
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        transactionsAssembly: @escaping TransactionsAssembly
    ) {
        self.tabBarController = tabBarController
        self.transactionsAssembly = transactionsAssembly
        
        self.resolver = resolver
        
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func start() {
        let view = transactionsAssembly(self, resolver)
        
        navigationController.setRootViewController(view)
        tabBarController.setTab(viewController: navigationController, for: .transactions)
    }
}

extension TransactionsCoordinator: TransactionsPresenterOutput {
    
}
