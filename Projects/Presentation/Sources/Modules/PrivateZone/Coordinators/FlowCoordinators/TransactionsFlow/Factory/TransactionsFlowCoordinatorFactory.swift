//
//  TransactionsFlowCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

final class TransactionsFlowCoordinatorFactory {
    private init() {}
    
    static func create(resolver: Resolver) -> TransactionsFlowCoordinatorInput {
        TransactionsFlowCoordinator(
            resolver: resolver,
            transactionsRouterAssembly: TransactionsAssembly.router,
            createTransactionsRouterAssembly: CreateTransactionAssembly.router
        )
    }
}
