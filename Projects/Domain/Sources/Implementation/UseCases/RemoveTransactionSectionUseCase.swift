//
//  RemoveTransactionSectionUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol RemoveTransactionSectionUseCaseProtocol: AnyObject {
    func execute(
        transactionSection: TransactionSectionEntity,
        completion: @escaping UpdateTransactionSectionCompletion
    )
}

public final class RemoveTransactionSectionUseCase: RemoveTransactionSectionUseCaseProtocol {
    private let repository: TransactionSectionsRepository
    
    public init(repository: TransactionSectionsRepository) {
        self.repository = repository
    }
    
    public func execute(
        transactionSection: TransactionSectionEntity,
        completion: @escaping UpdateTransactionSectionCompletion
    ) {
        repository.remove(by: transactionSection.id) { result in
            switch result {
            case .success: completion(.success(transactionSection))
            case let .failure(error): completion(.failure(.repository(error)))
            }
        }
    }
}
