//
//  AlertType.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 05.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

enum AlertType {
    case nameIsEmpty, unknown(error: Error)
    
    var title: String? {
        switch self {
        case .nameIsEmpty: Strings.Alert.NameIsNil.title
        case .unknown: Strings.Alert.Unknown.title
        }
    }
    
    var message: String? {
        switch self {
        case .nameIsEmpty: nil
        case .unknown(error: let error): error.localizedDescription
        }
    }
    
    var actions: [UIAlertAction] {
        switch self {
        case .nameIsEmpty, .unknown: [.OK]
        }
    }
}
