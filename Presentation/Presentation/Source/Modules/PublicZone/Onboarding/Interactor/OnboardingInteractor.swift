//
//  OnboardingInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import Domain

protocol OnboardingInteractorOutput: AnyObject {
    func display(page: Int?)
    func set(items: [OnboardingItemEntity])
    func changeButtonTitle(for page: Int?)
}

protocol OnboardingInteractorInput: AnyObject {
    var output: OnboardingInteractorOutput? { get set }
    
    func getItems()
    func getCurrentItem()
    func getNextItem(from page: Int)
    func getNeededChangeButtonTitleItem()
    func setCurrentPage(_ newPage: Int)
    func finishOnboarding()
}

final class OnboardingInteractor: OnboardingInteractorInput {
    weak var output: OnboardingInteractorOutput?
    
    private let useCase: OnboardingUseCase
    
    init(useCase: OnboardingUseCase) {
        self.useCase = useCase
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }

    func getNextItem(from page: Int) {
        let currentPage = useCase.getCurrentPage()
        let nextPage: Int?
        
        if page >= currentPage {
            nextPage = useCase.getNextPage()
        } else {
            nextPage = page + 1
        }
        
        output?.display(page: nextPage)
    }
    
    func getItems() {
        let items = useCase.getItems()
        output?.set(items: items)
    }
    
    func getCurrentItem() {
        let currentPage = useCase.getCurrentPage()
        output?.display(page: currentPage)
    }
    
    func getNeededChangeButtonTitleItem() {
        let lastPage = useCase.getLastPage()
        output?.changeButtonTitle(for: lastPage)
    }
    
    func setCurrentPage(_ newPage: Int) {
        let currentPage = useCase.getCurrentPage()
        
        if currentPage < newPage {
            useCase.setCurrentPage(newPage)
        }
    }
    
    func finishOnboarding() {
        useCase.finishOnboarding()
    }
}

