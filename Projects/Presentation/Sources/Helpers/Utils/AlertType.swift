//
//  AlertType.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 05.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

enum AlertType {
    case nameIsEmpty
    
    var title: String? {
        switch self {
        case .nameIsEmpty: Strings.Alert.NameIsNil.title
        }
    }
    
    var message: String? {
        switch self {
        case .nameIsEmpty: nil
        }
    }
    
    var actions: [UIAlertAction] {
        switch self {
        case .nameIsEmpty: [.default]
        }
    }
}
