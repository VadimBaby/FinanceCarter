//
//  CategoriesAssembly.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Domain

final class CategoriesAssembly {
    private init() {}
    
    static func create(router: CategoriesPresenterOutput, resolver: Resolver) -> CategoriesViewInput & UIViewController {
        let view = CategoriesView()
        let interactor = CategoriesInteractor(
            fetchUseCase: resolver.resolve(FetchCategoriesUseCaseProtocol.self)!,
            removeUseCase: resolver.resolve(RemoveCategoryUseCaseProtocol.self)!
        )
        
        let presenter = CategoriesPresenter(interactor: interactor, view: view)
        presenter.output = router
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
    
    static func router(
        navigationController: UINavigationController,
        resolver: Resolver
    ) -> CategoriesRouterInput {
        let router = CategoriesRouter(navigationController: navigationController, resolver: resolver)
        router.moduleAssembly = Self.create
        return router
    }
}

#if DEBUG
extension CategoriesAssembly {
    static func createMock() -> CategoriesViewInput & UIViewController {
        let view = CategoriesView()
        let interactor = CategoriesInteractor(
            fetchUseCase: MockFetchCategoriesUseCase(),
            removeUseCase: MockRemoveCategoryUseCase()
        )
        
        let presenter = CategoriesPresenter(interactor: interactor, view: view)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
#endif
