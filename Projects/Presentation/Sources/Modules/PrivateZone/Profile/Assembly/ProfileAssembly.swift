//
//  ProfileAssembly.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

final class ProfileAssembly {
    private init() {}
    
    private static func create(router: ProfilePresenterOutput, resolver: Resolver) -> ProfileViewInput & UIViewController {
        let view = ProfileView()
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        presenter.output = router
        
        return view
    }
    
    static func router(
        navigationController: UINavigationController,
        resolver: Resolver
    ) -> ProfileRouterInput {
        let router = ProfileRouter(navigationController: navigationController, resolver: resolver)
        router.moduleAssembly = Self.create
        return router
    }
}

#if DEBUG
extension ProfileAssembly {
    static func createMock() -> ProfileViewInput & UIViewController {
        let view = ProfileView()
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
#endif
