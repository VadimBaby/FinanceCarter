//
//  CategoriesPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

protocol CategoriesPresenterOutput: AnyObject {
    
}

protocol CategoriesPresenterInput: AnyObject {
    var output: CategoriesPresenterOutput? { get set }
}

final class CategoriesPresenter: CategoriesPresenterInput {
    weak var output: CategoriesPresenterOutput?
    
    private let interactor: CategoriesInteractorInput
    private unowned var view: CategoriesViewInput
    
    init(interactor: CategoriesInteractorInput, view: CategoriesViewInput) {
        self.view = view
        self.interactor = interactor
    }
}

extension CategoriesPresenter: CategoriesViewOutput {
    
}

extension CategoriesPresenter: CategoriesInteractorOutput {
    
}
