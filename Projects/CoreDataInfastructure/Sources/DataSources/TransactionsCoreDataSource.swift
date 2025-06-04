//
//  TransactionsCoreDataSource.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation
import Data
import Common
import Domain

public final class TransactionsCoreDataSource: CoreDataStore, TransactionsLocalDataSource {
    public func fetchTransactions() -> Result<[TransactionEntity], Error> {
        do {
            let entities = try fetch(type: DBTransaction.self)
            let domainEntities = TransactionMapper.toDomain(from: entities)
            return .success(domainEntities)
        } catch {
            return .failure(error)
        }
    }
    
    public func addTransaction(_ transaction: TransactionEntity) -> OperationResult<Error> {
        guard let category = fetchCategory(by: transaction.category.id),
              let wallet = fetchWallet(by: transaction.wallet.id) else { return .failure(URLError(.badServerResponse))}
        
        let newTransaction = DBTransaction(context: store.viewContext)
        newTransaction.id = transaction.id
        newTransaction.category = category
        newTransaction.wallet = wallet
        newTransaction.amount = transaction.amount
        newTransaction.createdAt = transaction.createdAt
        
        let type = transaction.category.type
        
        switch type {
        case .income: wallet.balance += transaction.amount
        case .spending: wallet.balance -= transaction.amount
        }
        
        do {
            try saveContext()
            return .success
        } catch {
            return .failure(error)
        }
    }
    
    public func removeTransaction(by id: UUID) -> OperationResult<Error> {
        do {
            let entities = try fetch(type: DBTransaction.self)
            guard let entity = entities.first(where: { $0.id == id }) else { return .success }
            try delete(entity: entity)
            return .success
        } catch {
            return .failure(error)
        }
    }
}

// MARK: - Private Methods

private extension TransactionsCoreDataSource {
    func fetchCategory(by id: UUID) -> DBCategory? {
        guard let categories = try? fetch(type: DBCategory.self) else { return nil }
        let category = categories.first(where: { $0.id == id })
        return category
    }
    
    func fetchWallet(by id: UUID) -> DBWallet? {
        guard let wallets = try? fetch(type: DBWallet.self) else { return nil }
        let wallet = wallets.first(where: { $0.id == id })
        return wallet
    }
}
