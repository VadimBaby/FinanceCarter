//
//  CreateCategoryInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 19.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain

protocol CreateCategoryInteractorOutput: AnyObject {
    func categoryDidAdded()
    func throwError(_ error: CreateCategoryViewError)
}

protocol CreateCategoryInteractorInput: AnyObject {
    var output: CreateCategoryInteractorOutput? { get set }
    
    func addCategory(type: TypeSegmentedControlItem, title: String)
}

final class CreateCategoryInteractor: CreateCategoryInteractorInput {
    weak var output: CreateCategoryInteractorOutput?
    
    private let useCase: CategoriesUseCase
    
    init(useCase: CategoriesUseCase) {
        self.useCase = useCase
        
        print("\(self) init")
    }
    
    deinit {
        print("\(self) deinit")
    }
    
    func addCategory(type: TypeSegmentedControlItem, title: String) {
        let categoryType = categoryType(from: type)
        
        guard title.count > 2 else { output?.throwError(.segmentOrTextFieldIsIncorrect); return }
        
        useCase.addCategory(title: title, type: categoryType) { [weak self] result in
            switch result {
            case .success:
                self?.output?.categoryDidAdded()
            case let .failure(error):
                debugPrint(error)
                self?.output?.throwError(.backend)
            }
        }
    }
}

// MARK: - Private Methods

private extension CreateCategoryInteractor {
    func categoryType(from type: TypeSegmentedControlItem) -> CategoryType {
        switch type {
        case .income: .income
        case .spending: .spending
        }
    }
}
