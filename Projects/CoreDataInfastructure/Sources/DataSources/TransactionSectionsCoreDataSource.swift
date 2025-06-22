//
//  TransactionSectionsCoreDataDataSource.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import MyCommon
import Data
import Domain
import Foundation
import MyCoreDataWrapper

public final class TransactionSectionsCoreDataSource: TransactionSectionsLocalDataSource {
    private let store: CoreDataStorage
    
    public init(store: CoreDataStorage) {
        self.store = store
    }
    
    public func fetch() -> Result<[TransactionSectionEntity], DataSourceError> {
        do {
            let entities = try store.fetch(type: DBTransactionSection.self)
            let domainEntities = TransactionSectionMapper.toDomain(from: entities)
            return .success(domainEntities)
        } catch {
            return .failure(.cannotFetch)
        }
    }
    
    public func fetch(by date: Date) -> Result<TransactionSectionEntity, DataSourceError> {
        do {
            guard let entity = try store.fetch(by: date, type: DBTransactionSection.self),
                  let domain = TransactionSectionMapper.toDomain(from: entity) else { return .failure(.cannotFetch) }
            return .success(domain)
        } catch {
            return .failure(.cannotFetch)
        }
    }
    
    public func create(_ section: TransactionSectionEntity) -> OperationResult<DataSourceError> {
        do {
            let ids = section.transactions.map(\.id)
            let dbTransactions = try store.fetch(by: ids, type: DBTransaction.self)
            
            try store.create(type: DBTransactionSection.self) { entity in
                entity.id = section.id
                entity.date = section.date
                entity.spendingAmount = section.spendingAmount
                entity.totalAmount = section.totalAmount
                entity.transactions = NSSet(array: dbTransactions)
            }
            
            return .success
        } catch {
            return .failure(.cannotCreate)
        }
    }
    
    public func add(
        transactions: [TransactionEntity],
        to section: TransactionSectionEntity
    ) -> OperationResult<DataSourceError> {
        do {
            guard let entity = try store.fetch(by: section.id, type: DBTransactionSection.self) else { return .failure(.cannotUpdate) }
                  
            guard var domainTransactions = TransactionSectionMapper.toDomain(from: entity)?.transactions else { return .failure(.cannotUpdate) }
            
            domainTransactions.append(contentsOf: transactions)
            
            let ids = domainTransactions.map(\.id)
            
            let dbTransactions = try store.fetch(by: ids, type: DBTransaction.self)
            
            try store.update(entity: entity) {
                $0.transactions = NSSet(array: dbTransactions)
            }
            
            return .success
        } catch {
            return .failure(.cannotUpdate)
        }
    }
    
    public func remove(by id: UUID) -> OperationResult<DataSourceError> {
        do {
            guard let entity = try store.fetch(by: id, type: DBTransactionSection.self) else { return .success }
            try store.delete(entity: entity)
            return .success
        } catch {
            return .failure(.cannotRemove)
        }
    }
}
