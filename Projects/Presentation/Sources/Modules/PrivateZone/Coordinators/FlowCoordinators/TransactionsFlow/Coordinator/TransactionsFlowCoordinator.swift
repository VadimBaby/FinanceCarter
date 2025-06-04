//
//  TransactionsFlowCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Common

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
    typealias CreateTransactionRouterAssembly = (_ navigationController: UINavigationController, _ resolver: Resolver) -> CreateTransactionRouterInput
    
    private let transactionsRouterAssembly: TransactionsRouterAssembly
    private let createTransactionRouterAssembly: CreateTransactionRouterAssembly
    
    private var transactionsRouter: TransactionsRouterInput?
    private var createTransactionRouter: CreateTransactionRouterInput?
    
    init(
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        transactionsRouterAssembly: @escaping TransactionsRouterAssembly,
        createTransactionsRouterAssembly: @escaping CreateTransactionRouterAssembly
    ) {
        self.transactionsRouterAssembly = transactionsRouterAssembly
        self.createTransactionRouterAssembly = createTransactionsRouterAssembly
        
        self.resolver = resolver
        
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        print("\(Self.self) init")
    }
    
    private var updateTransactionsViewClosure: VoidAction?
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func start() {
        defer { delegate?.transactionsFlowCoordinatorDidStart(with: navigationController) }
        openTransactionsScreen()
    }
}

// MARK: - Private Methods

private extension TransactionsFlowCoordinator {
    func openTransactionsScreen() {
        transactionsRouter = transactionsRouterAssembly(navigationController, resolver)
        transactionsRouter?.delegate = self
        transactionsRouter?.open()
    }
    
    func openCreateTransactionScreen() {
        createTransactionRouter = createTransactionRouterAssembly(navigationController, resolver)
        createTransactionRouter?.delegate = self
        createTransactionRouter?.open()
    }
    
    func closeCreateTransactionScreen() {
        createTransactionRouter?.close()
        createTransactionRouter = nil
        updateTransactionsViewClosure = nil
    }
}

// MARK: - TransactionsRouterOutput

extension TransactionsFlowCoordinator: TransactionsRouterOutput {
    func transactionsAddButtonDidTap(updateTransactionsViewClosure: @escaping VoidAction) {
        self.updateTransactionsViewClosure = updateTransactionsViewClosure
        openCreateTransactionScreen()
    }
}

// MARK: - CreateTransactionRouterOutput

extension TransactionsFlowCoordinator: CreateTransactionRouterOutput {
    func createTransactionCloseButtonDidPressed() {
        self.closeCreateTransactionScreen()
    }
    
    func transactionDidAdded() {
        self.updateTransactionsViewClosure?()
        self.closeCreateTransactionScreen()
    }
}
