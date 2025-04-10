//
//  TransactionsFlowCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol TransactionsFlowCoordinatorOutput: AnyObject {
    func transactionsFlowCoordinatorDidStart(with viewController: UIViewController)
}

protocol TransactionsFlowCoordinatorInput: NavigationCoordinator {
    var delegate: TransactionsFlowCoordinatorOutput? { get set }
}

final class TransactionsFlowCoordinator: TransactionsFlowCoordinatorInput {
    weak var delegate: TransactionsFlowCoordinatorOutput?
    
    private let resolver: Resolver
    
    let navigationController: UINavigationController
    
    typealias TransactionsRouterAssembly = (_ navigationController: UINavigationController, _ resolver: Resolver) -> TransactionsRouterInput
    
    private let transactionsRouterAssembly: TransactionsRouterAssembly
    
    private var transactionsRouter: TransactionsRouterInput?
    
    init(
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        transactionsRouterAssembly: @escaping TransactionsRouterAssembly
    ) {
        self.transactionsRouterAssembly = transactionsRouterAssembly
        
        self.resolver = resolver
        
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func start() {
        transactionsRouter = transactionsRouterAssembly(navigationController, resolver)
        transactionsRouter?.delegate = self
        transactionsRouter?.open()
        delegate?.transactionsFlowCoordinatorDidStart(with: navigationController)
    }
}

extension TransactionsFlowCoordinator: TransactionsRouterOutput {
    
}
