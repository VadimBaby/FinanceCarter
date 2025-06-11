//
//  CreateCategoryPresenter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 19.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

protocol CreateCategoryPresenterOutput: AnyObject {
    func closeButtonDidPressed()
    func categoryDidAdded()
}

protocol CreateCategoryPresenterInput: AnyObject {
    var output: CreateCategoryPresenterOutput? { get set }
}

final class CreateCategoryPresenter: CreateCategoryPresenterInput {
    weak var output: CreateCategoryPresenterOutput?
    
    private let interactor: CreateCategoryInteractorInput
    private unowned let view: CreateCategoryViewInput
    
    init(interactor: CreateCategoryInteractorInput, view: CreateCategoryViewInput) {
        self.interactor = interactor
        self.view = view
    }
}

// MARK: - CreateCategoryInteractorOutput

extension CreateCategoryPresenter: CreateCategoryInteractorOutput {
    func categoryDidAdded() {
        output?.categoryDidAdded()
    }
    
    func throwError(_ error: Error) {
        view.showError(error)
    }
}

// MARK: - CreateCategoryViewOutput

extension CreateCategoryPresenter: CreateCategoryViewOutput {
    func closeButtonDidPressed() {
        output?.closeButtonDidPressed()
    }
    
    func emojiDidPicked(_ emoji: String) {
        interactor.setEmoji(emoji)
    }
    
    func addButtonDidPressed(type: TypeSegmentedControlItem, title: String) {
        interactor.addCategory(type: type, title: title)
    }
}
