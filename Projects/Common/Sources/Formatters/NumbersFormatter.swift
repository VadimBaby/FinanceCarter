//
//  NumbersFormatter.swift
//  Common
//
//  Created by Вадим Мартыненко on 25.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation

public struct NumbersFormatter {
    public static func formatWithMinimalDecimals(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.roundingMode = .down
        
        guard let formattedString = formatter.string(from: NSNumber(value: number)) else { return String(number) }
        
        return formattedString
    }
}
