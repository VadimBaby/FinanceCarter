//
//  String.swift
//  Common
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

// TODO: - Вынести это в отдельный пакет, чтобы можно было использовать это в других своих проектах

public extension String {
    var isNotEmpty: Bool {
        !isEmpty
    }
    
    static var empty: String {
        ""
    }
    
    static var rubleSign: String {
        "₽"
    }
    
    static var space: String {
        " "
    }
    
    static var plusSign: String {
        "+"
    }
    
    static var minusSign: String {
        "-"
    }
}
