//
//  UITextField+Custom.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import Common

extension UITextField {
    static func primary(placeholder: String, backgroundColor: UIColor = .secondarySystemBackground) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.backgroundColor = backgroundColor
        textField.layer.cornerRadius = 15
        
        let leftView = UIView() &> { $0.frame.size = .init(width: 20, height: 1) }
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        return textField
    }
}
