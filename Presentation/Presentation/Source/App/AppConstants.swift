//
//  AppConstants.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import Domain

enum AppConstants {
    static let onboardingItems: [OnboardingItemEntity] = [
        .init(
            image: Asset.Images.Onboarding.firstOnboardingImage.image,
            title: Strings.Onboarding.First.title,
            description: Strings.Onboarding.First.description
        ),
        .init(
            image: Asset.Images.Onboarding.secondOnboardingImage.image,
            title: Strings.Onboarding.Second.title,
            description: Strings.Onboarding.Second.description
        ),
        .init(
            image: Asset.Images.Onboarding.thirdOnboardingImage.image,
            title: Strings.Onboarding.Third.title,
            description: Strings.Onboarding.Third.description
        )
    ]
}
