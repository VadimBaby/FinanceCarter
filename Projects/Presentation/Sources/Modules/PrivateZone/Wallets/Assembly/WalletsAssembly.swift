//
//  WalletsAssembly.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Domain

final class WalletsAssembly {
    private init() {}
    
    static func create(coordinator: WalletsPresenterOutput, resolver: Resolver) -> WalletsViewInput & UIViewController {
        let view = WalletsView()
        let interactor = WalletsInteractor(useCase: resolver.resolve(WalletsUseCase.self)!)
        
        let presenter = WalletsPresenter(interactor: interactor, view: view)
        presenter.output = coordinator
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
    
    static func router(
        navigationController: UINavigationController,
        resolver: Resolver
    ) -> WalletsRouterInput {
        let router = WalletsRouter(
            navigationController: navigationController,
            resolver: resolver
        )
        router.moduleAssembly = Self.create
        return router
    }
}

#if DEBUG
extension WalletsAssembly {
    static func createMock() -> WalletsViewInput & UIViewController {
        let view = WalletsView()
        let interactor = WalletsInteractor(useCase: MockWalletsService())
        
        let presenter = WalletsPresenter(interactor: interactor, view: view)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
#endif
