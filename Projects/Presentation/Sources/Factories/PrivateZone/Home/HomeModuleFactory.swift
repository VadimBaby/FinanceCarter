//
//  HomeModuleFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

final class HomeModuleFactory {
    private init() {}
    
    static func create(coordinator: HomePresenterOutput, resolver: Resolver) -> HomeViewInput & UIViewController {
        let view = HomeView(homeHeaderAssembly: { cell in
            HomeHeaderCellFactory.create(view: cell, resolver: resolver)
        })
        
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        presenter.output = coordinator
        
        return view
    }
}

#if DEBUG
extension HomeModuleFactory {
    static func createMock() -> HomeViewInput & UIViewController {
        let view = HomeView(homeHeaderAssembly: HomeHeaderCellFactory.createMock)
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: view, interactor: interactor)
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
#endif
