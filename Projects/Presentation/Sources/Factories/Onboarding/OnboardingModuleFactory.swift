//
//  OnboardingModuleFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit
import Domain

final class OnboardingModuleFactory {
    private init() {}
    
    static func create(
        coordinator: OnboardingPresenterOutput,
        resolver: Resolver
    ) -> UIViewController & OnboardingViewInput {
        let view = OnboardingView()
        let interactor = OnboardingInteractor(
            useCase: resolver.resolve(OnboardingUseCase.self, argument: AppConstants.onboardingItems)!
        )
        let presenter = OnboardingPresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        presenter.output = coordinator
        
        return view
    }
}

#if DEBUG
extension OnboardingModuleFactory {
    static func createMock() -> UIViewController & OnboardingViewInput {
        let view = OnboardingView()
        let interactor = OnboardingInteractor(useCase: MockOnboardingService(onboardingItems: AppConstants.onboardingItems))
        let presenter = OnboardingPresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
#endif
