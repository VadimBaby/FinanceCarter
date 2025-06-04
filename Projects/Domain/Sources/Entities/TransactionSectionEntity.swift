//
//  TransactionSectionEntity.swift
//  Domain
//
//  Created by Вадим Мартыненко on 01.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation

public struct TransactionSectionEntity {
    public let id: UUID
    public let date: Date
    public let amount: Double
    public let transactions: [TransactionEntity]
    
    public init(id: UUID = .init(), date: Date, amount: Double, transactions: [TransactionEntity]) {
        self.id = id
        self.date = date
        self.amount = amount
        self.transactions = transactions
    }
    
    public func copyWith(
        id: UUID? = nil,
        date: Date? = nil,
        amount: Double? = nil,
        transactions: [TransactionEntity]? = nil
    ) -> TransactionSectionEntity {
        .init(
            id: id ?? self.id,
            date: date ?? self.date,
            amount: amount ?? self.amount,
            transactions: transactions ?? self.transactions
        )
    }
}
