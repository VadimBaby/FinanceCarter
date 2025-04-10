//
//  TransactionsAssembly.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

final class TransactionsAssembly {
    private init() {}
    
    static func create(coordinator: TransactionsPresenterOutput, resolver: Resolver) -> TransactionsViewInput & UIViewController {
        let view = TransactionsView()
        let interactor = TransactionsInteractor()
        
        let presenter = TransactionsPresenter(interactor: interactor, view: view)
        presenter.output = coordinator
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
    
    static func router(tabBarController: UIAppTabBarController, resolver: Resolver) -> TabBarItemCoordinator {
        return TransactionsRouter(
            tabBarController: tabBarController,
            resolver: resolver,
            transactionsAssembly: Self.create
        )
    }
}
