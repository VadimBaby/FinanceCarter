//
//  FetchTransactionSectionUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol FetchTransactionSectionsUseCaseProtocol: AnyObject {
    func execute(completion: @escaping FetchTransactionSectionsCompletion)
}

public final class FetchTransactionSectionsUseCase: FetchTransactionSectionsUseCaseProtocol {
    private let repository: TransactionSectionsRepositoryProtocol
    
    public init(repository: TransactionSectionsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(completion: @escaping FetchTransactionSectionsCompletion) {
        repository.fetch { result in
            switch result {
            case let .success(entities): completion(.success(entities))
            case let .failure(error): completion(.failure(.repository(error)))
            }
        }
    }
}
