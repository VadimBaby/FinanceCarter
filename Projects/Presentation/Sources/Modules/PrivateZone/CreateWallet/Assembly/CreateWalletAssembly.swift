//
//  CreateWalletAssembly.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 25.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Domain

final class CreateWalletAssembly {
    private init() {}
    
    static func create(router: CreateWalletPresenterOutput, resolver: Resolver) -> CreateWalletViewInput & UIViewController {
        let view = CreateWalletView()
        let interactor = CreateWalletInteractor(useCase: resolver.resolve(CreateWalletUseCaseProtocol.self)!)
        
        let presenter = CreateWalletPresenter(interactor: interactor, view: view)
        presenter.output = router
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
    
    static func router(
        navigationController: UINavigationController,
        resolver: Resolver
    ) -> CreateWalletRouterInput {
        let router = CreateWalletRouter(navigationController: navigationController, resolver: resolver)
        router.moduleAssembly = Self.create
        return router
    }
}

#if DEBUG
extension CreateWalletAssembly {
    static func createMock() -> CreateWalletViewInput & UIViewController {
        let view = CreateWalletView()
        let interactor = CreateWalletInteractor(useCase: MockCreateWalletUseCase())
        
        let presenter = CreateWalletPresenter(interactor: interactor, view: view)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
#endif
