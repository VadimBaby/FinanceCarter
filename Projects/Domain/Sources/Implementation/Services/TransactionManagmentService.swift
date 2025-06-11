//
//  TransactionsService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class TransactionManagmentService: TransactionManagmentUseCase, TransactionManaging {
    private let repository: TransactionsRepository
    
    public init(repository: TransactionsRepository) {
        self.repository = repository
    }
    
    public func fetch(completion: @escaping FetchTransactionsCompletion) {
        repository.fetch { result in
            switch result {
            case let .success(entities): completion(.success(entities))
            case let .failure(error): completion(.failure(.repository(error)))
            }
        }
    }
    
    public func create(category: CategoryEntity, wallet: WalletEntity, amount: Double, completion: @escaping UpdateTransactionCompletion) {
        let transaction = TransactionEntity(category: category, wallet: wallet, amount: amount)
        repository.create(transaction) { result in
            switch result {
            case .success:
                completion(.success(transaction))
            case let .failure(error):
                completion(.failure(.repository(error)))
            }
        }
    }
    
    public func remove(_ transaction: TransactionEntity, completion: @escaping UpdateTransactionCompletion) {
        repository.remove(by: transaction.id) { result in
            switch result {
            case .success:
                completion(.success(transaction))
            case let .failure(error):
                completion(.failure(.repository(error)))
            }
        }
    }
}
