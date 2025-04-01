//
//  OnboardingRepository.swift
//  Domain
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

public protocol OnboardingUseCase: AnyObject {
    func getItems() -> [OnboardingItemEntity]
    func getCurrentPage() -> Int
    func getNextPage() -> Int?
    func getLastPage() -> Int?
    
    func setCurrentPage(_ newPage: Int)
    func finishOnboarding()
}
