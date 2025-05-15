//
//  UILabel+Style.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 15.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

extension UILabel {
    static func textfield(text: String) -> UILabel {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = text
        return label
    }
}
