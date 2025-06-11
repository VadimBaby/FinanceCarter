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

public final class TransactionSectionsCoreDataSource: TransactionSectionsLocalDataSource {
    private let store: CoreDataStore
    private let transactionSectionRawDataFetcher: TransactionSectionRawDataFetcher
    private let transactionRawDataFetcher: TransactionRawDataFetcher
    
    public init(
        transactionSectionRawDataFetcher: TransactionSectionRawDataFetcher,
        transactionRawDataFetcher: TransactionRawDataFetcher,
        store: CoreDataStore
    ) {
        self.store = store
        self.transactionRawDataFetcher = transactionRawDataFetcher
        self.transactionSectionRawDataFetcher = transactionSectionRawDataFetcher
    }
    
    public func fetch() -> Result<[TransactionSectionEntity], DataSourceError> {
        do {
            let entities = try transactionSectionRawDataFetcher.fetch()
            let domainEntities = TransactionSectionMapper.toDomain(from: entities)
            return .success(domainEntities)
        } catch {
            return .failure(.cannotFetch)
        }
    }
    
    public func fetch(by date: Date) -> Result<TransactionSectionEntity, DataSourceError> {
        do {
            guard let entity = try transactionSectionRawDataFetcher.fetch(by: date),
                  let domain = TransactionSectionMapper.toDomain(from: entity) else { return .failure(.cannotFetch) }
            return .success(domain)
        } catch {
            return .failure(.cannotFetch)
        }
    }
    
    public func create(_ section: TransactionSectionEntity) -> OperationResult<DataSourceError> {
        do {
            let ids = section.transactions.map(\.id)
            let dbTransactions = try transactionRawDataFetcher.fetch(by: ids)
            
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
            guard let entity = try transactionSectionRawDataFetcher.fetch(by: section.id) else { return .failure(.cannotUpdate) }
                  
            guard var domainTransactions = TransactionSectionMapper.toDomain(from: entity)?.transactions else { return .failure(.cannotUpdate) }
            
            domainTransactions.append(contentsOf: transactions)
            
            let dbTransactions = try transactionRawDataFetcher.fetch(by: domainTransactions.map(\.id))
            
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
            guard let entity = try transactionSectionRawDataFetcher.fetch(by: id) else { return .success }
            try store.delete(entity: entity)
            return .success
        } catch {
            return .failure(.cannotRemove)
        }
    }
}
