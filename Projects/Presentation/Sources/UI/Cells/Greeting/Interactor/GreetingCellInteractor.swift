//
//  HomeHeaderCellInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 06.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

protocol GreetingCellInteractorOutput: AnyObject {
    func didGetUserName(_ name: String)
}

protocol GreetingCellInteractorInput: AnyObject {
    var output: GreetingCellInteractorOutput? { get set }
    
    func getUseName()
}

final class GreetingCellInteractor: GreetingCellInteractorInput {
    weak var output: GreetingCellInteractorOutput?
    
    private let useCase: AccountUseCase
    
    init(useCase: AccountUseCase) {
        self.useCase = useCase
    }
    
    func getUseName() {
        let name = useCase.getUserName()
        output?.didGetUserName(name)
    }
}
