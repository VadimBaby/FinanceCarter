//
//  UILabel+Style.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 15.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import MyCommon

extension UILabel {
    static func placeholder(text: String) -> UILabel {
        UILabel() &> {
            $0.font = .preferredFont(forTextStyle: .headline)
            $0.text = text
        }
    }
}
