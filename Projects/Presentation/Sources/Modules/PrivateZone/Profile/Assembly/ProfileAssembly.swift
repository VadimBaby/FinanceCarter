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
    
    static func create(coordinator: ProfilePresenterOutput, resolver: Resolver) -> ProfileViewInput & UIViewController {
        let view = ProfileView()
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        presenter.output = coordinator
        
        return view
    }
    
    static func router(tabBarController: UIAppTabBarController, resolver: Resolver) -> TabBarItemCoordinator {
        ProfileRouter(tabBarController: tabBarController, resolver: resolver, profileAssembly: Self.create)
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

