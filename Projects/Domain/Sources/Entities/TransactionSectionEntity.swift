//
//  TransactionSectionEntity.swift
//  Domain
//
//  Created by Вадим Мартыненко on 01.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation

public struct TransactionSectionEntity {
    public let id: UUID
    public let date: Date
    public let transactions: [TransactionEntity]
    
    public init(id: UUID = .init(), date: Date, transactions: [TransactionEntity]) {
        self.id = id
        self.date = date
        self.transactions = transactions
    }
}

// MARK: - Calculated Variables

public extension TransactionSectionEntity {
    // TODO: Порешать это
    var totalAmount: Double {
        transactions.reduce(Double.zero) { result, entity in
            let type = entity.category.type
            
            switch type {
            case .income: return result + entity.amount
            case .spending: return result - entity.amount
            }
        }
    }
    
    var spendingAmount: Double {
        transactions.reduce(Double.zero) { result, entity in
            let type = entity.category.type
            
            if type == .spending {
                return result + entity.amount
            }
            
            return result
        }
    }
}

// MARK: - Copy With

public extension TransactionSectionEntity {
    func copyWith(
        id: UUID? = nil,
        date: Date? = nil,
        transactions: [TransactionEntity]? = nil
    ) -> TransactionSectionEntity {
        .init(
            id: id ?? self.id,
            date: date ?? self.date,
            transactions: transactions ?? self.transactions
        )
    }
}
