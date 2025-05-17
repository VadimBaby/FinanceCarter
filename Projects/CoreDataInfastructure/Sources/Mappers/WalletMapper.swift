//
//  WalletMapper.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import CoreData

struct WalletMapper {
    static func toDomain(from entity: DBWallet) -> WalletEntity {
        WalletEntity(
            id: entity.id.orRandom,
            title: entity.title.orEmpty,
            balance: entity.balance,
            createdAt: entity.createdAt.orNow
        )
    }
    
    static func toDomain(from entities: [DBWallet]) -> [WalletEntity] {
        entities.map{ toDomain(from: $0) }.sorted(by: { $0.createdAt > $1.createdAt })
    }
}
