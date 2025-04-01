//
//  Optional.swift
//  Common
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

public extension Optional {
    var isNil: Bool {
        self == nil
    }
    
    var isNotNil: Bool {
        self != nil
    }
}
