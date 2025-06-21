//
//  CreateTransactionAssembly.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Domain

final class CreateTransactionAssembly {
    private init() {}
    
    static func create(router: CreateTransactionPresenterOutput, resolver: Resolver) -> CreateTransactionViewInput & UIViewController {
        let view = CreateTransactionView()
        let interactor = CreateTransactionInteractor(
            createTransactionUseCase: resolver.resolve(CreateTransactionUseCaseProtocol.self)!,
            fetchWalletUseCase: resolver.resolve(FetchWalletsUseCaseProtocol.self)!,
            fetchCategoriesUseCase: resolver.resolve(FetchCategoriesUseCaseProtocol.self)!
        )
        let presenter = CreateTransactionPresenter(interactor: interactor, view: view)
        presenter.output = router
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
    
    static func router(
        navigationController: UINavigationController,
        resolver: Resolver
    ) -> CreateTransactionRouterInput {
        let router = CreateTransactionRouter(navigationController: navigationController, resolver: resolver)
        router.moduleAssembly = Self.create
        return router
    }
}

// MARK: - Mock

#if DEBUG
extension CreateTransactionAssembly {
    static func createMock() -> CreateTransactionViewInput & UIViewController {
        let view = CreateTransactionView()
        let interactor = CreateTransactionInteractor(
            createTransactionUseCase: MockCreateTransactionUseCase(),
            fetchWalletUseCase: MockFetchWalletsUseCase(),
            fetchCategoriesUseCase: MockFetchCategoriesUseCase())
        
        let presenter = CreateTransactionPresenter(interactor: interactor, view: view)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
#endif
