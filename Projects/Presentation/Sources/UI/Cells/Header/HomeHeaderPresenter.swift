//
//  HomeHeaderCellPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 06.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

protocol HomeHeaderCellPresenterOutput: AnyObject {
    
}

protocol HomeHeaderCellPresenterInput: AnyObject {
    var output: HomeHeaderCellPresenterOutput? { get set }
}

final class HomeHeaderPresenter: HomeHeaderCellPresenterInput {
    weak var output: HomeHeaderCellPresenterOutput?
    
    private unowned var view: HomeHeaderViewInput
    private let interactor: HomeHeaderInteractorInput
    
    init(view: HomeHeaderViewInput, interactor: HomeHeaderInteractorInput) {
        self.view = view
        self.interactor = interactor
    }
}

extension HomeHeaderPresenter: HomeHeaderViewOutput {
    func viewDidConfigure() {
        interactor.getUseName()
    }
}

extension HomeHeaderPresenter: HomeHeaderInteractorOutput {
    func didGetUserName(_ name: String) {
        view.updateUserName(name)
    }
}
