//
//  OnboardingItemPresentationModel.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Domain

struct OnboardingItemPresentationEntity: Equatable {
    let image: UIImage
    let title: String
    let description: String
    
    static let mock = OnboardingItemPresentationEntity(
        image: Asset.Images.Onboarding.firstOnboardingImage.image,
        title: "Title",
        description: "Description"
    )
}

extension OnboardingItemPresentationEntity {
    init(from entity: OnboardingItem) {
        switch entity.image {
        case .first:
            self.image = Asset.Images.Onboarding.firstOnboardingImage.image
        case .second:
            self.image = Asset.Images.Onboarding.secondOnboardingImage.image
        case .third:
            self.image = Asset.Images.Onboarding.thirdOnboardingImage.image
        }
        
        self.title = entity.title
        self.description = entity.description
    }
}
