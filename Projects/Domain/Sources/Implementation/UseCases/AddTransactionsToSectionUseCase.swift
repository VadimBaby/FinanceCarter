//
//  AddTransactionsToTransactionsSectionsUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol AddTransactionsToSectionUseCaseProtocol: AnyObject {
    func execute(
        transactions: [TransactionEntity],
        section: TransactionSectionEntity,
        completion: @escaping UpdateTransactionSectionCompletion
    )
}

public final class AddTransactionsToSectionUseCase: AddTransactionsToSectionUseCaseProtocol {
    private let repository: TransactionSectionsRepository
    
    public init(repository: TransactionSectionsRepository) {
        self.repository = repository
    }
    
    public func execute(
        transactions: [TransactionEntity],
        section: TransactionSectionEntity,
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
