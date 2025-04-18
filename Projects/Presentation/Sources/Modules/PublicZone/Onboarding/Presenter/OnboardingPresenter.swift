//
//  OnboardingPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import Domain

protocol OnboardingPresenterOutput: AnyObject {
    func onboardingDidFinish()
}

protocol OnboardingPresenterInput: AnyObject {
    var output: OnboardingPresenterOutput? { get set }
}

final class OnboardingPresenter: OnboardingPresenterInput {
    weak var output: OnboardingPresenterOutput?
    
    private unowned var view: OnboardingViewInput
    private let interactor: OnboardingInteractorInput
    
    private var items: [OnboardingItemPresentationEntity] = []
    
    init(view: OnboardingViewInput, interactor: OnboardingInteractorInput) {
        self.view = view
        self.interactor = interactor
    }
}

extension OnboardingPresenter: OnboardingViewOutput {
    func viewDidConfigure() {
        interactor.getCurrentItem()
        interactor.getNeededChangeButtonTitleItem()
    }
    
    func buttonPressed(from page: Int) {
        interactor.getNextItem(from: page)
    }
    
    func viewDidLoad() {
        interactor.getItems()
    }
    
    func pageSwiped(to page: Int) {
        interactor.setCurrentPage(page)
    }
}

extension OnboardingPresenter: OnboardingInteractorOutput {
    func display(page: Int?) {
        guard let page else { onboardingDidFinish(); return }
        interactor.setCurrentPage(page)
        view.presentItem(with: page)
    }
    
    func changeButtonTitle(for page: Int?) {
        guard let page else { return }
        view.changeButtonTitle(at: page)
    }
    
    func set(items: [OnboardingItemPresentationEntity]) {
        guard items.count > 0 else { onboardingDidFinish(); return }
        self.items = items
        view.configure(with: items)
    }
}

private extension OnboardingPresenter {
    func onboardingDidFinish() {
        interactor.finishOnboarding()
        output?.onboardingDidFinish()
    }
}
