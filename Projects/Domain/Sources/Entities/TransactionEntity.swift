//
//  TransactionEntity.swift
//  Domain
//
//  Created by Вадим Мартыненко on 28.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation

public struct TransactionEntity: Identifiable, CreatedAtContainable {
    public let id: UUID
    public let category: CategoryEntity
    public let wallet: WalletEntity
    public let amount: Double
    public let createdAt: Date
    
    public init(
        id: UUID = .init(),
        category: CategoryEntity,
        wallet: WalletEntity,
        amount: Double,
        createdAt: Date = .now
    ) {
        self.id = id
        self.category = category
        self.wallet = wallet
        self.amount = amount
        self.createdAt = createdAt
    }
}

// MARK: - Equatable

extension TransactionEntity: Equatable, Hashable {
    public static func == (lhs: TransactionEntity, rhs: TransactionEntity) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
