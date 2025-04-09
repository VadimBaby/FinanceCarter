//
//  HomeHeaderCellFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 06.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

final class HomeHeaderCellFactory {
    private init() {}
    
    static func create(view: HomeHeaderViewInput, resolver: Resolver) -> HomeHeaderViewOutput {
        let interactor = HomeHeaderInteractor(useCase: resolver.resolve(AccountUseCase.self)!)
        let presenter = HomeHeaderPresenter(view: view, interactor: interactor)
        interactor.output = presenter
        view.output = presenter
        
        return presenter
    }
}

#if DEBUG
extension HomeHeaderCellFactory {
    static func createMock(view: HomeHeaderViewInput) -> HomeHeaderViewOutput {
        let interactor = HomeHeaderInteractor(useCase: MockAccountService())
        let presenter = HomeHeaderPresenter(view: view, interactor: interactor)
        interactor.output = presenter
        view.output = presenter
        
        return presenter
    }
}
#endif
