//
//  TransactionSectionsStorageManager.swift
//  Data
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import MyCommon
import Foundation

public final class TransactionSectionsRepository: TransactionSectionsRepositoryProtocol {
    private let localDataSource: TransactionSectionsLocalDataSource
    
    public init(localDataSource: TransactionSectionsLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    public func fetch(completion: @escaping (Result<[TransactionSectionEntity], DataError>) -> Void) {
        let result = localDataSource.fetch()
        switch result {
        case let .success(entities): completion(.success(entities))
        case let .failure(error): completion(.failure(error.toDataError()))
        }
    }
    
    public func fetch(
        by date: Date,
        completion: @escaping (Result<TransactionSectionEntity, DataError>) -> Void
    ) {
        let result = localDataSource.fetch(by: date)
        switch result {
        case let .success(entity): completion(.success(entity))
        case let .failure(error): completion(.failure(error.toDataError()))
        }
    }
    
    public func create(_ section: TransactionSectionEntity, completion: @escaping OperationResultCompletionWithDataError) {
        let result = localDataSource.create(section)
        switch result {
        case .success: completion(.success)
        case let .failure(error): completion(.failure(error.toDataError()))
        }
    }
    
    public func add(
        transactions: [TransactionEntity],
        to section: TransactionSectionEntity,
        completion: @escaping OperationResultCompletionWithDataError
    ) {
        let result = localDataSource.add(transactions: transactions, to: section)
        switch result {
        case .success: completion(.success)
        case let .failure(error): completion(.failure(error.toDataError()))
        }
    }
    
    public func remove(by id: UUID, completion: @escaping OperationResultCompletionWithDataError) {
        let result = localDataSource.remove(by: id)
        switch result {
        case .success: completion(.success)
        case let .failure(error): completion(.failure(error.toDataError()))
        }
    }
}
