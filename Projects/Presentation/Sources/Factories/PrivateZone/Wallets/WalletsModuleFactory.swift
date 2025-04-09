//
//  WalletsModuleFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

final class WalletsModuleFactory {
    private init() {}
    
    static func create(coordinator: WalletsPresenterOutput, resolver: Resolver) -> WalletsViewInput & UIViewController {
        let view = WalletsView()
        let interactor = WalletsInteractor()
        
        let presenter = WalletsPresenter(interactor: interactor, view: view)
        presenter.output = coordinator
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}
