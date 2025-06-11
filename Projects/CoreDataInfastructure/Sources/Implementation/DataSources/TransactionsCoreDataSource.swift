//
//  TransactionsCoreDataSource.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Data
import MyCommon
import Domain

public final class TransactionsCoreDataSource: TransactionsLocalDataSource {
    private let walletRawDataFetcher: WalletRawDataFetcher
    private let categoryRawDataFetcher: CategoryRawDataFetcher
    private let transactionRawDataFetcher: TransactionRawDataFetcher
    private let store: CoreDataStore
    
    public init(
        transactionRawDataFetcher: TransactionRawDataFetcher,
        walletRawDataFetcher: WalletRawDataFetcher,
        categoryRawDataFetcher: CategoryRawDataFetcher,
        store: CoreDataStore
    ) {
        self.transactionRawDataFetcher = transactionRawDataFetcher
        self.walletRawDataFetcher = walletRawDataFetcher
        self.categoryRawDataFetcher = categoryRawDataFetcher
        self.store = store
    }
    
    public func fetch() -> Result<[TransactionEntity], DataSourceError> {
        do {
            let entities = try transactionRawDataFetcher.fetch()
            let domainEntities = TransactionMapper.toDomain(from: entities)
            return .success(domainEntities)
        } catch {
            return .failure(.cannotFetch)
        }
    }
    
    public func create(_ transaction: TransactionEntity) -> OperationResult<DataSourceError> {
        do {
            guard let category = try categoryRawDataFetcher.fetch(by: transaction.category.id),
                  let wallet = try walletRawDataFetcher.fetch(by: transaction.wallet.id) else { return .failure(.cannotCreate)}
            
            try store.create(type: DBTransaction.self) { entity in
                entity.id = transaction.id
                entity.category = category
                entity.wallet = wallet
                entity.amount = transaction.amount
                entity.createdAt = transaction.createdAt
            }
            
            return .success
        } catch {
            return .failure(.cannotCreate)
        }
    }
    
    public func remove(by id: UUID) -> OperationResult<DataSourceError> {
        do {
            guard let entity = try transactionRawDataFetcher.fetch(by: id) else { return .success }
            try store.delete(entity: entity)
            return .success
        } catch {
            return .failure(.cannotCreate)
        }
    }
}
