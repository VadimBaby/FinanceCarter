//
//  MockOnboardingService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 22.03.2025.
//


import Foundation
import Common

public final class MockOnboardingService: OnboardingUseCase {
    private let items: [OnboardingItemEntity]
    
    private var currentPage = 0
    
    public init(
        onboardingItems items: [OnboardingItemEntity]
    ) {
        self.items = items
    }
    
    public func getItems() -> [OnboardingItemEntity] {
        items
    }
    
    public func getCurrentPage() -> Int {
        currentPage
    }
    
    public func setCurrentPage(_ newPage: Int) {
        currentPage = newPage
    }
    
    public func getLastPage() -> Int? {
        guard items.isNotEmpty else { return nil }
        return items.count - 1
    }
    
    public func getNextPage() -> Int? {
        let currentPage = getCurrentPage()
        let nextPage = currentPage + 1
        
        guard nextPage < items.count else { return nil }
        
        return nextPage
    }
    
    public func finishOnboarding() {
        print("onboarding is finished")
    }
}

