//
//  ProfileModuleFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

final class ProfileModuleFactory {
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
}

#if DEBUG
extension ProfileModuleFactory {
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
