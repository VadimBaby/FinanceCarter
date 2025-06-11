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
            transactionManager: resolver.resolve(TransactionManaging.self)!,
            walletsUseCase: resolver.resolve(WalletManagmentUseCase.self)!,
            categoriesUseCase: resolver.resolve(CategoryManagmentUseCase.self)!
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
            transactionManager: MockTransactionManagmentService(),
            walletsUseCase: MockWalletManagmentService(),
            categoriesUseCase: MockCategoryManagmentService()
        )
        
        let presenter = CreateTransactionPresenter(interactor: interactor, view: view)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
#endif
