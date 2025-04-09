//
//  CategoriesModuleFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

final class CategoriesModuleFactory {
    private init() {}
    
    static func create(coordinator: CategoriesPresenterOutput, resolver: Resolver) -> CategoriesViewInput & UIViewController {
        let view = CategoriesView()
        let interactor = CategoriesInteractor()
        
        let presenter = CategoriesPresenter(interactor: interactor, view: view)
        presenter.output = coordinator
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
