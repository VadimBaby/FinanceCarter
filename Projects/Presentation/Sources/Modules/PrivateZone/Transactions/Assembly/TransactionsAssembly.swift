//
//  TransactionsAssembly.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Domain

final class TransactionsAssembly {
    private init() {}
    
    static func create(router: TransactionsPresenterOutput, resolver: Resolver) -> TransactionsViewInput & UIViewController {
        let view = TransactionsView()
        let interactor = TransactionsInteractor(useCase: resolver.resolve(TransactionSectionManagmentUseCase.self)!)
        
        let presenter = TransactionsPresenter(interactor: interactor, view: view)
        presenter.output = router
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
    
    static func router(
        navigationController: UINavigationController,
        resolver: Resolver
    ) -> TransactionsRouterInput {
        let router = TransactionsRouter(navigationController: navigationController, resolver: resolver)
        router.moduleAssembly = Self.create
        return router
    }
}

// MARK: - Mock

#if DEBUG
extension TransactionsAssembly {
    static func createMock() -> TransactionsViewInput & UIViewController {
        let view = TransactionsView()
        let interactor = TransactionsInteractor(useCase: MockTransactionSectionManagmentService())
        
        let presenter = TransactionsPresenter(interactor: interactor, view: view)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
#endif
