//
//  MockCreateTransactionUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class MockCreateTransactionUseCase: CreateTransactionUseCaseProtocol {
    public init() {}
    
    public func execute(category: CategoryEntity, wallet: WalletEntity, amount: Double, completion: @escaping UpdateTransactionCompletion) {
        let transaction = TransactionEntity(category: category, wallet: wallet, amount: amount)
        completion(.success(transaction))
    }
}
