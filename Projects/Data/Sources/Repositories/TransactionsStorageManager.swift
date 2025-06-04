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
import Common

public final class TransactionsStorageManager: TransactionsRepository {
    private let localDataSource: TransactionsLocalDataSource
    
    public init(localDataSource: TransactionsLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    public func fetchTransactions(completion: @escaping (Result<[TransactionEntity], any Error>) -> Void) {
        let result = localDataSource.fetchTransactions()
        completion(result)
    }
    
    public func addTransaction(_ transaction: TransactionEntity, completion: @escaping OperationResultCompletion) {
        let result = localDataSource.addTransaction(transaction)
        completion(result)
    }
    
    public func removeTransaction(by id: UUID, completion: @escaping OperationResultCompletion) {
        let result = localDataSource.removeTransaction(by: id)
        completion(result)
    }
}
