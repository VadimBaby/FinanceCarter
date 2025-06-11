//
//  CreateDateContainable.swift
//  Domain
//
//  Created by Вадим Мартыненко on 23.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation

public protocol CreatedAtContainable {
    var createdAt: Date { get }
}

public enum TypeSortByCreateDate {
    case up, down
}

public extension Array where Element: CreatedAtContainable {
    func sortedByCreatedAt(_ sort: TypeSortByCreateDate = .down) -> Self {
        switch sort {
        case .up:
            return self.sorted(by: { $0.createdAt < $1.createdAt })
        case .down:
            return self.sorted(by: { $0.createdAt > $1.createdAt })
        }
    }
    
    mutating func sortByCreatedAt(_ sort: TypeSortByCreateDate = .down) {
        let sorted = sortedByCreatedAt(sort)
        self = sorted
    }
}
