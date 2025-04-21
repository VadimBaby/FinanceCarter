//
//  HomeHeaderCellPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 06.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

protocol GreetingCellPresenterOutput: AnyObject {
    
}

protocol GreetingCellPresenterInput: AnyObject {
    var output: GreetingCellPresenterOutput? { get set }
}

final class GreetingCellPresenter: GreetingCellPresenterInput {
    weak var output: GreetingCellPresenterOutput?
    
    private unowned var view: GreetingCellViewInput
    private let interactor: GreetingCellInteractorInput
    
    init(view: GreetingCellViewInput, interactor: GreetingCellInteractorInput) {
        self.view = view
        self.interactor = interactor
    }
}

extension GreetingCellPresenter: GreetingCellViewOutput {
    func viewDidConfigure() {
        interactor.getUseName()
    }
}

extension GreetingCellPresenter: GreetingCellInteractorOutput {
    func didGetUserName(_ name: String) {
        view.updateUserName(name)
    }
}
