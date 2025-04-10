//
//  CredentialAssembly.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Domain

final class CredentialAssembly {
    private init() {}
    
    static func create(
        router: CredentialPresenterOutput,
        resolver: Resolver
    ) -> UIViewController & CredentialViewInput {
        let view = CredentialView()
        let interactor = CredentialInteractor(useCase: resolver.resolve(AccountUseCase.self)!)
        let presenter = CredentialPresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        presenter.output = router
        
        return view
    }
    
    static func router(
        navigationController: UINavigationController,
        resolver: Resolver
    ) -> CredentialRouterInput {
        let router = CredentialRouter(navigationController: navigationController, resolver: resolver)
        router.moduleAssembly = Self.create
        return router
    }
}

// MARK: - Mock
#if DEBUG
extension CredentialAssembly {
    static func createMock() -> UIViewController & CredentialViewInput {
        let view = CredentialView()
        let interactor = CredentialInteractor(useCase: MockAccountService())
        let presenter = CredentialPresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
#endif
