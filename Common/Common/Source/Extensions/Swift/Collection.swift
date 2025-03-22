//
//  Collection.swift
//  Common
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    var isNotEmpty: Bool {
        !isEmpty
    }
}
