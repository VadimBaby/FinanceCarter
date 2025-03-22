//
//  UIButton+Custom.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

extension UIButton {
    static func primary(title: String, backgroundColor: UIColor = Asset.Colors.buttonColor.color) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = backgroundColor
        configuration.baseForegroundColor = .white
        configuration.background.cornerRadius = 15
        configuration.attributedTitle = AttributedString(title, attributes: AttributeContainer([.font: UIFont.my(font: .buttonTitle)]))
        
        return UIButton(configuration: configuration)
    }
}
