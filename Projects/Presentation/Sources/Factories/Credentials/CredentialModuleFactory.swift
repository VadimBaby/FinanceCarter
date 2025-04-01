//
//  CredentialModuleFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

final class CredentialModuleFactory {
    private init() {}
    
    static func create(
        coordinator: CredentialPresenterOutput,
        resolver: Resolver
    ) -> UIViewController & CredentialViewInput {
        let view = CredentialView()
        let interactor = CredentialInteractor()
        let presenter = CredentialPresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        presenter.output = coordinator
        
        return view
    }
}

// MARK: - Mock
#if DEBUG
extension CredentialModuleFactory {
    static func createMock() -> UIViewController & CredentialViewInput {
        let view = CredentialView()
        let interactor = CredentialInteractor()
        let presenter = CredentialPresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
#endif
