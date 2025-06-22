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
import MyCoreDataWrapper

public final class TransactionsCoreDataSource: TransactionsLocalDataSource {
    private let store: CoreDataStorage
    
    public init(store: CoreDataStorage) {
        self.store = store
    }
    
    public func fetch() -> Result<[TransactionEntity], DataSourceError> {
        do {
            let entities = try store.fetch(type: DBTransaction.self)
            let domainEntities = TransactionMapper.toDomain(from: entities)
            return .success(domainEntities)
        } catch {
            return .failure(.cannotFetch)
        }
    }
    
    public func create(_ transaction: TransactionEntity) -> OperationResult<DataSourceError> {
        do {
            let categoryID = transaction.category.id
            let walletID = transaction.wallet.id
            
            guard let category = try store.fetch(by: categoryID, type: DBCategory.self),
                  let wallet = try store.fetch(by: walletID, type: DBWallet.self) else { return .failure(.cannotCreate)}
            
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
            guard let entity = try store.fetch(by: id, type: DBTransaction.self) else { return .success }
            try store.delete(entity: entity)
            return .success
        } catch {
            return .failure(.cannotCreate)
        }
    }
}
