//
//  NoName.swift
//  Common
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public enum OperationResult<T: Error> {
    case success
    case failure(T)
}
