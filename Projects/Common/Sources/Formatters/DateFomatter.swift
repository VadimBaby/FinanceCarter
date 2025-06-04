//
//  DateFomatter.swift
//  Common
//
//  Created by Вадим Мартыненко on 01.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Foundation

public struct DateFomatter {
    public static func toMonthAndDayString(from date: Date) -> String {
        let formatter = DateFormatter() &> {
            $0.dateFormat = "MMMM d"
            $0.locale = .current
        }
        
        let string = formatter.string(from: date)
        return string
    }
}
