//
//  HomeHeaderCellInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 06.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

protocol HomeHeaderInteractorOutput: AnyObject {
    func didGetUserName(_ name: String)
}

protocol HomeHeaderInteractorInput: AnyObject {
    var output: HomeHeaderInteractorOutput? { get set }
    
    func getUseName()
}

final class HomeHeaderInteractor: HomeHeaderInteractorInput {
    weak var output: HomeHeaderInteractorOutput?
    
    private let useCase: AccountUseCase
    
    init(useCase: AccountUseCase) {
        self.useCase = useCase
    }
    
    func getUseName() {
        let name = useCase.getUserName()
        output?.didGetUserName(name)
    }
}
