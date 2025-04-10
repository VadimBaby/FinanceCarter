//
//  OnboardingService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import Common

public final class OnboardingService: OnboardingUseCase {
    private let items: [OnboardingItemEntity]
    
    private let settingsStorage: SettingsStorageProtocol
    
    public init(
        settingsStorage: SettingsStorageProtocol,
        onboardingItems items: [OnboardingItemEntity]
    ) {
        self.settingsStorage = settingsStorage
        self.items = items
    }
    
    public func getItems() -> [OnboardingItemEntity] {
        items
    }
    
    public func getCurrentPage() -> Int {
        settingsStorage.currentOnboardingPage
    }
    
    public func setCurrentPage(_ newPage: Int) {
        settingsStorage.currentOnboardingPage = newPage
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
        settingsStorage.isOnboardingCompleted = true
    }
}
