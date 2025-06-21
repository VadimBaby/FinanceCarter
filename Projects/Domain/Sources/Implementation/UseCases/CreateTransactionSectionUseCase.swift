//
//  CreateTransactionSectionUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation

public protocol CreateTransactionSectionUseCaseProtocol: AnyObject {
    func execute(
        transactions: [TransactionEntity],
        date: Date,
        completion: @escaping UpdateTransactionSectionCompletion
    )
}

public final class CreateTransactionSectionUseCase: CreateTransactionSectionUseCaseProtocol {
    private let repository: TransactionSectionsRepositoryProtocol
    
    public init(repository: TransactionSectionsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(
        transactions: [TransactionEntity],
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
}
