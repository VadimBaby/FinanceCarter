//
//  Wallet.swift
//  Domain
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation

public struct WalletEntity: Identifiable, CreatedAtContainable {
    public let id: UUID
    public let title: String
    public let balance: Double
    public let createdAt: Date
    
    public init(
        id: UUID = .init(),
        title: String,
        balance: Double,
        createdAt: Date = .now
    ) {
        self.id = id
        self.title = title
        self.balance = balance
        self.createdAt = createdAt
    }
}

// MARK: - Copy With

public extension WalletEntity {
    func copyWith(
        id: UUID? = nil,
        title: String? = nil,
        balance: Double? = nil,
        createdAt: Date? = nil
    ) -> WalletEntity {
        WalletEntity(
            id: id ?? self.id,
            title: title ?? self.title,
            balance: balance ?? self.balance,
            createdAt: createdAt ?? self.createdAt
        )
    }
}

// MARK: - Mock

extension WalletEntity {
    static let mock = WalletEntity(title: "Тинькофф", balance: 13999)
}
