//
//  AppConstants.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import Domain
// swiftlint:disable:next foundation_using
import Foundation

struct AppConstants {
    static let onboardingItems: [OnboardingItem] = [
        .init(
            image: .first,
            title: Strings.Onboarding.First.title,
            description: Strings.Onboarding.First.description
        ),
        .init(
            image: .second,
            title: Strings.Onboarding.Second.title,
            description: Strings.Onboarding.Second.description
        ),
        .init(
            image: .third,
            title: Strings.Onboarding.Third.title,
            description: Strings.Onboarding.Third.description
        )
    ]
    
    static let padding: CGFloat = 20
    static let innerPadding: CGFloat = 10
    static let smallPadding: CGFloat = 5
    static let verticalSpacingSmall: CGFloat = 10
    static let verticalSpacingMedium: CGFloat = 20
    static let textFieldHeight: CGFloat = 50
    static let buttonHeight: CGFloat = 50
}
