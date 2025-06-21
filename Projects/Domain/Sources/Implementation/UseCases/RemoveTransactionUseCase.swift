//
//  RemoveTransactionUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol RemoveTransactionUseCaseProtocol: AnyObject {
    func execute(transaction: TransactionEntity, completion: @escaping UpdateTransactionCompletion)
}

public final class RemoveTransactionUseCase: RemoveTransactionUseCaseProtocol {
    private let repository: TransactionsRepositoryProtocol
    
    init(repository: TransactionsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(transaction: TransactionEntity, completion: @escaping UpdateTransactionCompletion) {
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
