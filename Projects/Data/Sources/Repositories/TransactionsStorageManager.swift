//
//  TransactionsStorageManager.swift
//  Data
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Domain
import MyCommon

public final class TransactionsStorageManager: TransactionsRepository {
    private let localDataSource: TransactionsLocalDataSource
    
    public init(localDataSource: TransactionsLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    public func fetch(completion: @escaping (Result<[TransactionEntity], DataError>) -> Void) {
        let result = localDataSource.fetch()
        switch result {
        case let .success(entities): completion(.success(entities))
        case let .failure(error): completion(.failure(error.toDataError()))
        }
    }
    
    public func create(_ transaction: TransactionEntity, completion: @escaping OperationResultCompletionWithDataError) {
        let result = localDataSource.create(transaction)
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
