//
//  Date.swift
//  Common
//
//  Created by Вадим Мартыненко on 01.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation

public extension Date {
    var currentDayDate: Date {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: dateComponents)!
        return date
    }
}
