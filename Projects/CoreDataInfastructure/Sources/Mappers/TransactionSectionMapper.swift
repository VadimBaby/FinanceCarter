//
//  TransactionSectionMapper.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import Foundation

struct TransactionSectionMapper {
    static func toDomain(from entity: DBTransactionSection) -> TransactionSectionEntity? {
        guard let dbTransactions = entity.transactions as? Set<DBTransaction> else { return nil }
        
        let transactions = TransactionMapper.toDomain(from: Array(dbTransactions))
        
        return TransactionSectionEntity(
            id: entity.id.orRandom,
            date: entity.date.orNow,
            transactions: transactions
        )
    }
    
    static func toDomain(from entities: [DBTransactionSection]) -> [TransactionSectionEntity] {
        entities.compactMap{ toDomain(from: $0) }.sorted(by: { $0.date > $1.date })
    }
}
