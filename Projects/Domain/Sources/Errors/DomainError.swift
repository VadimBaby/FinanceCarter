//
//  DomainError.swift
//  Domain
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation

public enum DomainError: LocalizedError {
    case repository(_ error: DataError), invalidName
    
    public var errorDescription: String? {
        switch self {
        case .invalidName: "Name is invalid"
        case let .repository(error): error.errorDescription
        }
    }
}
