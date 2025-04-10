//
//  OnboardingAssembly.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Domain

final class OnboardingAssembly {
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
extension OnboardingAssembly {
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
