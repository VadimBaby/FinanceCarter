//
//  Optional.swift
//  Common
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

// swiftlint:disable:next foundation_using
import Foundation

public extension Optional {
    var isNil: Bool {
        self == nil
    }
    
    var isNotNil: Bool {
        self != nil
    }
}

// MARK: - String

public extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? .empty
    }
}

// MARK: - Double

public extension Optional where Wrapped == Double {
    var orZero: Double {
        self ?? .zero
    }
}

// MARK: - Int

public extension Optional where Wrapped == Int {
    var orZero: Int {
        self ?? .zero
    }
}

// MARK: - Date

public extension Optional where Wrapped == Date {
    var orNow: Date {
        self ?? .now
    }
}

// MARK: - UUID

public extension Optional where Wrapped == UUID {
    var orRandom: UUID {
        self ?? .init()
    }
}
