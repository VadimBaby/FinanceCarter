//
//  HomeHeaderAssembly.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

final class GreetingCellAssembly {
    private init() {}
    
    static func create(view: GreetingCellViewInput, resolver: Resolver) -> GreetingCellViewOutput {
        let interactor = GreetingCellInteractor(useCase: resolver.resolve(AccountUseCase.self)!)
        let presenter = GreetingCellPresenter(view: view, interactor: interactor)
        interactor.output = presenter
        view.output = presenter
        
        return presenter
    }
}

#if DEBUG
extension GreetingCellAssembly {
    static func createMock(view: GreetingCellViewInput) -> GreetingCellViewOutput {
        let interactor = GreetingCellInteractor(useCase: MockAccountService())
        let presenter = GreetingCellPresenter(view: view, interactor: interactor)
        interactor.output = presenter
        view.output = presenter
        
        return presenter
    }
}
#endif
