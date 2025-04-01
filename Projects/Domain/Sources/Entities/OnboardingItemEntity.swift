//
//  OnboardingItemEntity.swift
//  Domain
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit.UIImage

public struct OnboardingItemEntity: Equatable {
    public let image: UIImage
    public let title: String
    public let description: String
    
    public init(image: UIImage, title: String, description: String) {
        self.image = image
        self.title = title
        self.description = description
    }
    
    public static let mock = OnboardingItemEntity(
        image: UIImage.add,
        title: "Title",
        description: "Description"
    )
}
