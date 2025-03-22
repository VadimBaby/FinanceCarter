//
//  EdgeInsets.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

// MARK: - UIEdgeInsets

extension UIEdgeInsets {
    init(top: CGFloat) {
        self.init(top: top, left: 0, bottom: 0, right: 0)
    }
    
    init(left: CGFloat) {
        self.init(top: 0, left: left, bottom: 0, right: 0)
    }
    
    init(bottom: CGFloat) {
        self.init(top: 0, left: 0, bottom: bottom, right: 0)
    }
    
    init(right: CGFloat) {
        self.init(top: 0, left: 0, bottom: 0, right: right)
    }
    
    init(vertical: CGFloat) {
        self.init(top: vertical, left: 0, bottom: vertical, right: 0)
    }
    
    init(horizontal: CGFloat) {
        self.init(top: 0, left: horizontal, bottom: 0, right: horizontal)
    }
    
    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}

// MARK: - NSDirectionalEdgeInsets

extension NSDirectionalEdgeInsets {
    init(top: CGFloat) {
        self.init(top: top, leading: 0, bottom: 0, trailing: 0)
    }
    
    init(leading: CGFloat) {
        self.init(top: 0, leading: leading, bottom: 0, trailing: 0)
    }
    
    init(bottom: CGFloat) {
        self.init(top: 0, leading: 0, bottom: bottom, trailing: 0)
    }
    
    init(trailing: CGFloat) {
        self.init(top: 0, leading: 0, bottom: 0, trailing: trailing)
    }
    
    init(vertical: CGFloat) {
        self.init(top: vertical, leading: 0, bottom: vertical, trailing: 0)
    }
    
    init(horizontal: CGFloat) {
        self.init(top: 0, leading: horizontal, bottom: 0, trailing: horizontal)
    }
    
    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}
