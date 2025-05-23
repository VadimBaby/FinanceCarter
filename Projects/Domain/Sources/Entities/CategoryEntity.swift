//
//  Category.swift
//  Domain
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation

public enum CategoryType: String {
    case income, spending
}

public struct CategoryEntity: Identifiable, CreatedAtContainable {
    public let id: UUID
    public let title: String
    public let type: CategoryType
    public let createdAt: Date
    
    public init(id: UUID, title: String, type: CategoryType, createdAt: Date) {
        self.id = id
        self.title = title
        self.type = type
        self.createdAt = createdAt
    }
    
    public init(title: String, type: CategoryType) {
        self.init(id: .init(), title: title, type: type, createdAt: .now)
    }
}
