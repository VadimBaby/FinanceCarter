//
//  CategoriesLocalDataSourceError.swift
//  Data
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

public enum DataSourceError: Error {
    case cannotFetch, cannotCreate, cannotRemove, cannotUpdate
    
    func toDataError() -> DataError {
        switch self {
        case .cannotFetch: .cannotFetch
        case .cannotCreate: .cannotCreate
        case .cannotRemove: .cannotRemove
        case .cannotUpdate: .cannotUpdate
        }
    }
}
