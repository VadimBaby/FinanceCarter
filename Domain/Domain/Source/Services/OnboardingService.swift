//
//  OnboardingService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import Common

public final class OnboardingService: OnboardingUseCase {
    private let items: [OnboardingItemEntity]
    
    private let repository: KeyValueStorageRepository
    
    public init(
        repository: KeyValueStorageRepository,
        onboardingItems items: [OnboardingItemEntity]
    ) {
        self.repository = repository
        self.items = items
    }
    
    public func getItems() -> [OnboardingItemEntity] {
        items
    }
    
    public func getCurrentPage() -> Int {
        repository.currentOnboardingPage
    }
    
    public func setCurrentPage(_ newPage: Int) {
        repository.currentOnboardingPage = newPage
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
        repository.isOnboardingCompleted = true
    }
}
