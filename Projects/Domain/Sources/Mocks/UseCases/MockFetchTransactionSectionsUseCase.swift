//
//  MockFetchTransactionSectionsUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class MockFetchTransactionSectionsUseCase: FetchTransactionSectionsUseCaseProtocol {
    public init() {}
    
    public func execute(completion: @escaping FetchTransactionSectionsCompletion) {
        completion(.success([
            .init(date: .now, transactions: [.init(category: .mock, wallet: .mock, amount: 1333)])
        ]))
    }
}
