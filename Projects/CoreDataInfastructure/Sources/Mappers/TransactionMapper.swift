//
//  TransactionMapper.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import CoreData
import MyCommon

struct TransactionMapper {
    static func toDomain(from entity: DBTransaction) -> TransactionEntity? {
        guard let dbCategory = entity.category,
              let dbWallet = entity.wallet,
              let category = CategoryMapper.toDomain(from: dbCategory) else { return nil }
        
        return TransactionEntity(
            id: entity.id.orRandom,
            category: category,
            wallet: WalletMapper.toDomain(from: dbWallet),
            amount: entity.amount,
            createdAt: entity.createdAt.orNow
        )
    }
    
    static func toDomain(from entities: [DBTransaction]) -> [TransactionEntity] {
        entities.compactMap{ toDomain(from: $0) }.sortedByCreatedAt()
    }
}
