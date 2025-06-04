//
//  TransactionEntity.swift
//  Domain
//
//  Created by Вадим Мартыненко on 28.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation

public struct TransactionEntity: Identifiable, CreatedAtContainable {
    public let id: UUID
    public let category: CategoryEntity
    public let wallet: WalletEntity
    public let amount: Double
    public let createdAt: Date
    
    public init(id: UUID, category: CategoryEntity, wallet: WalletEntity, amount: Double, createdAt: Date) {
        self.id = id
        self.category = category
        self.wallet = wallet
        self.amount = amount
        self.createdAt = createdAt
    }
    
    public init(category: CategoryEntity, wallet: WalletEntity, amount: Double) {
        self.id = .init()
        self.category = category
        self.wallet = wallet
        self.amount = amount
        self.createdAt = .now
    }
}

// MARK: - Equatable

extension TransactionEntity: Equatable, Hashable {
    public static func == (lhs: TransactionEntity, rhs: TransactionEntity) -> Bool {
        lhs.id == rhs.id
    }
    
    
    // TODO: - Насколько правильно?
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(category.id)
        hasher.combine(wallet.id)
        hasher.combine(amount)
        hasher.combine(createdAt)
    }
}
