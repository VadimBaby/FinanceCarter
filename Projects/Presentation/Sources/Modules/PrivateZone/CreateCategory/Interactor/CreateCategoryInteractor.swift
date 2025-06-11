//
//  CreateCategoryInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 19.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import Foundation

protocol CreateCategoryInteractorOutput: AnyObject {
    func categoryDidAdded()
    func throwError(_ error: Error)
}

protocol CreateCategoryInteractorInput: AnyObject {
    var output: CreateCategoryInteractorOutput? { get set }
    
    func addCategory(type: TypeSegmentedControlItem, title: String)
    func setEmoji(_ emoji: String)
}

final class CreateCategoryInteractor: CreateCategoryInteractorInput {
    weak var output: CreateCategoryInteractorOutput?
    
    private let useCase: CategoryManagmentUseCase
    
    private var emoji: String?
    
    init(useCase: CategoryManagmentUseCase) {
        self.useCase = useCase
        
        print("\(self) init")
    }
    
    deinit {
        print("\(self) deinit")
    }
    
    private enum Error: LocalizedError {
        case segmentOrTextFieldIsIncorrect, emojiInvalid
        
        var errorDescription: String? {
            switch self {
            case .segmentOrTextFieldIsIncorrect: Strings.CreateCategory.Error.segmentOrTextFieldIsIncorrect
            case .emojiInvalid: Strings.CreateCategory.Error.emojiInvalid
            }
        }
    }
    
    func addCategory(type: TypeSegmentedControlItem, title: String) {
        let categoryType = categoryType(from: type)
        
        guard title.count > 2 else { output?.throwError(Error.segmentOrTextFieldIsIncorrect); return }
        guard let emoji else { output?.throwError(Error.emojiInvalid); return }
        
        useCase.create(title: title, emoji: emoji, type: categoryType) { [weak self] result in
            switch result {
            case .success:
                self?.output?.categoryDidAdded()
            case let .failure(error):
                self?.output?.throwError(error)
            }
        }
    }
    
    func setEmoji(_ emoji: String) {
        self.emoji = emoji
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
