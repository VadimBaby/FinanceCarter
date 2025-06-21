//
//  CreateCategoryAssembly.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 19.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Domain

final class CreateCategoryAssembly {
    private init() {}
    
    static func create(router: CreateCategoryPresenterOutput, resolver: Resolver) -> UIViewController & CreateCategoryViewInput {
        let view = CreateCategoryView()
        let interactor = CreateCategoryInteractor(useCase: resolver.resolve(CreateCategoryUseCaseProtocol.self)!)
        let presenter = CreateCategoryPresenter(interactor: interactor, view: view)
        
        view.output = presenter
        interactor.output = presenter
        
        presenter.output = router
        
        return view
    }
    
    static func router(navigationController: UINavigationController, resolver: Resolver) -> CreateCategoryRouterInput {
        let router = CreateCategoryRouter(navigationController: navigationController, resolver: resolver)
        router.moduleAssembly = Self.create
        return router
    }
}

#if DEBUG
extension CreateCategoryAssembly {
    static func createMock() -> UIViewController & CreateCategoryViewInput {
        let view = CreateCategoryView()
        let interactor = CreateCategoryInteractor(useCase: MockCreateCategoryUseCase())
        let presenter = CreateCategoryPresenter(interactor: interactor, view: view)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
#endif
