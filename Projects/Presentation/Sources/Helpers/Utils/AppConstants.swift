//
//  AppConstants.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import Domain

enum AppConstants {
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
}
