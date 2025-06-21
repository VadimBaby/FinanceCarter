//
//  FetchOneTransactionSectionUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.//

import Foundation

public protocol FetchOneTransactionSectionUseCaseProtocol: AnyObject {
    func execute(date: Date, completion: @escaping UpdateTransactionSectionCompletion)
}

public final class FetchOneTransactionSectionUseCase: FetchOneTransactionSectionUseCaseProtocol {
    private let repository: TransactionSectionsRepository
    
    public init(repository: TransactionSectionsRepository) {
        self.repository = repository
    }
    
    public func execute(date: Date, completion: @escaping UpdateTransactionSectionCompletion) {
        repository.fetch(by: date) { result in
            switch result {
            case let .success(entity): completion(.success(entity))
            case let .failure(error): completion(.failure(.repository(error)))
            }
        }
    }
}
