//
//  CategoriesPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import Common

protocol CategoriesPresenterOutput: AnyObject {
    func addButtonDidPressed(updateCategoriesViewClosure: @escaping VoidAction)
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
    func viewDidLoad() {
        interactor.getCategories()
    }
    
    func categoryDidRemoved(_ category: CategoryEntity) {
        interactor.removeCategory(category)
    }
    
    func addButtonDidPressed() {
        output?.addButtonDidPressed(updateCategoriesViewClosure: { [weak self] in
            self?.interactor.getCategories()
        })
    }
}

extension CategoriesPresenter: CategoriesInteractorOutput {
    func categoriesDidGet(_ categories: [CategoryEntity]) {
        view.setCategories(categories)
    }
    
    func throwError(_ error: Error) {
        view.showError(error)
    }
}
