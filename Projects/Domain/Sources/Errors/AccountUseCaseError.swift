//
//  AccountUseCaseError.swift
//  Domain
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation

public enum AccountUseCaseError: Error, LocalizedError {
    case invalidName
    
    public var errorDescription: String? {
        switch self {
        case .invalidName: "Name is invalid"
        }
    }
}
