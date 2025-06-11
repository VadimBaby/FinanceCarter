//
//  DataError.swift
//  Domain
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation

public enum DataError: LocalizedError {
    case cannotFetch, cannotCreate, cannotUpdate, cannotRemove
    
    public var errorDescription: String? {
        switch self {
        case .cannotFetch: "Не удалось получить данные"
        case .cannotCreate: "Не удалось создать экземпляр"
        case .cannotUpdate: "Не удалось обновить экземпляр"
        case .cannotRemove: "Не удалось удалить экземпляр"
        }
    }
}
