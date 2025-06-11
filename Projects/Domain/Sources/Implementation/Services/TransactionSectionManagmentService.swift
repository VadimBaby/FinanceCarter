//
//  TransactionSectionManagmentService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation
import MyCommon

public final class TransactionSectionManagmentService: TransactionSectionManagmentUseCase {
    private let repository: TransactionSectionsRepository
    
    public init(repository: TransactionSectionsRepository) {
        self.repository = repository
    }
    
    public func fetch(completion: @escaping FetchTransactionSectionsCompletion) {
        repository.fetch { result in
            switch result {
            case let .success(entities): completion(.success(entities))
            case let .failure(error): completion(.failure(.repository(error)))
            }
        }
    }
    
    public func fetch(by date: Date, completion: @escaping UpdateTransactionSectionCompletion) {
        repository.fetch(by: date) { result in
            switch result {
            case let .success(entity): completion(.success(entity))
            case let .failure(error): completion(.failure(.repository(error)))
            }
        }
    }
    
    public func create(
        with transactions: [TransactionEntity],
        date: Date,
        completion: @escaping UpdateTransactionSectionCompletion
    ) {
        let section = TransactionSectionEntity(date: date.currentDayDate, transactions: transactions)
        repository.create(section) { result in
            switch result {
            case .success: completion(.success(section))
            case let .failure(error): completion(.failure(.repository(error)))
            }
        }
    }
    
    public func remove(_ transaction: TransactionSectionEntity, completion: @escaping UpdateTransactionSectionCompletion) {
        repository.remove(by: transaction.id) { result in
            switch result {
            case .success: completion(.success(transaction))
            case let .failure(error): completion(.failure(.repository(error)))
            }
        }
    }
    
    public func add(
        transactions: [TransactionEntity],
        to section: TransactionSectionEntity,
        completion: @escaping UpdateTransactionSectionCompletion
    ) {
        repository.add(transactions: transactions, to: section) { result in
            switch result {
            case let .failure(error): completion(.failure(.repository(error)))
            case .success:
                let transactions = section.transactions + transactions
                let sortedTransactions = transactions.sortedByCreatedAt()
                let updatedSection = section.copyWith(transactions: sortedTransactions)
                completion(.success(updatedSection))
            }
        }
    }
}
