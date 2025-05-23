//
//  AlertType.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 05.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

enum AlertType {
    case error(Error)
    
    var title: String? {
        switch self {
        case .error: Strings.Alert.Unknown.title
        }
    }
    
    var message: String? {
        switch self {
        case let .error(error): error.localizedDescription
        }
    }
    
    var actions: [UIAlertAction] {
        switch self {
        case .error: [.OK]
        }
    }
}
