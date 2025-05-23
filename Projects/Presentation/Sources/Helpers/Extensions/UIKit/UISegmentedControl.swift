//
//  UISegmentedControl.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 23.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    func titleForCurrentSegment() -> String? {
        titleForSegment(at: self.selectedSegmentIndex)
    }
}
