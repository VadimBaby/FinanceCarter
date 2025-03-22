//
//  MyFonts.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

enum MyFont {
    case title, description, buttonTitle
    
    func font() -> UIFont {
        switch self {
        case .title:
            return .systemFont(ofSize: 28, weight: .bold)
        case .description:
            return .systemFont(ofSize: 20, weight: .regular)
        case .buttonTitle:
            return .systemFont(ofSize: 20, weight: .medium)
        }
    }
}

extension UIFont {
    static func my(font: MyFont) -> UIFont {
        font.font()
    }
}
