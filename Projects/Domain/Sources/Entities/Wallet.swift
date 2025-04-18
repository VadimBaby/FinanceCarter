//
//  Wallet.swift
//  Domain
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation

public struct Wallet: Identifiable {
    public let id: UUID
    public let title: String
    public let balance: Double
    public let createdAt: Date
    
    public init(id: UUID, title: String, balance: Double, createdAt: Date) {
        self.id = id
        self.title = title
        self.balance = balance
        self.createdAt = createdAt
    }
    
    public init(title: String, balance: Double) {
        self.id = UUID()
        self.title = title
        self.balance = balance
        self.createdAt = .now
    }
}
