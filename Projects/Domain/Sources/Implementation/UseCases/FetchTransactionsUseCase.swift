//
//  FetchTransactionsUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol FetchTransactionsUseCaseProtocol: AnyObject {
    func execute(completion: @escaping FetchTransactionsCompletion)
}

public final class FetchTransactionsUseCase: FetchTransactionsUseCaseProtocol {
    private let repository: TransactionsRepositoryProtocol
    
    public init(repository: TransactionsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(completion: @escaping FetchTransactionsCompletion) {
        repository.fetch { result in
            switch result {
            case let .success(entities): completion(.success(entities))
            case let .failure(error): completion(.failure(.repository(error)))
            }
        }
    }
}
