//
//  OnboardingItemEntity.swift
//  Domain
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

public enum OnboardingImage {
    case first, second, third
}

public struct OnboardingItem: Equatable {
    public let image: OnboardingImage
    public let title: String
    public let description: String
    
    public init(image: OnboardingImage, title: String, description: String) {
        self.image = image
        self.title = title
        self.description = description
    }
    
    public static let mock = OnboardingItem(
        image: .first,
        title: "Title",
        description: "Description"
    )
}
