//
//  HomeAssembly.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

final class HomeAssembly {
    private init() {}
    
    private static func create(router: HomePresenterOutput, resolver: Resolver) -> HomeViewInput & UIViewController {
        let view = HomeView(greetingCellAssembly: { cell in
            GreetingCellAssembly.create(view: cell, resolver: resolver)
        })
        
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        presenter.output = router
        
        return view
    }
    
    static func router(
        navigationController: UINavigationController,
        resolver: Resolver
    ) -> HomeRouterInput {
        let router = HomeRouter(
            navigationController: navigationController,
            resolver: resolver
        )
        
        router.moduleAssembly = Self.create
        
        return router
    }
}

#if DEBUG
extension HomeAssembly {
    static func createMock() -> HomeViewInput & UIViewController {
        let view = HomeView(greetingCellAssembly: GreetingCellAssembly.createMock)
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
#endif
