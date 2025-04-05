//
//  UIViewController.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 05.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(type: AlertType) {
        let alertVC = UIAlertController(
            title: type.title,
            message: type.message,
            preferredStyle: .alert
        )
        
        for action in type.actions {
            alertVC.addAction(action)
        }
        
        self.present(alertVC, animated: true)
    }
}
