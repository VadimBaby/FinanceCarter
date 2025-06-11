//
//  CategoriesInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
// swiftlint:disable:next foundation_using
import Foundation

protocol CategoriesInteractorOutput: AnyObject {
    func categoriesDidGet(_ categories: [CategoryEntity])
    func throwError(_ error: Error)
    func removeCategoryDidFall(_ category: CategoryEntity)
}

protocol CategoriesInteractorInput: AnyObject {
    var output: CategoriesInteractorOutput? { get set }
    
    func getCategories()
    func removeCategory(_ category: CategoryEntity)
}

final class CategoriesInteractor: CategoriesInteractorInput {
    weak var output: CategoriesInteractorOutput?
    
    private let useCase: CategoryManagmentUseCase
    
    init(useCase: CategoryManagmentUseCase) {
        self.useCase = useCase
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func getCategories() {
        useCase.fetch { [weak self] result in
            switch result {
            case .success(let categories):
                self?.output?.categoriesDidGet(categories)
            case .failure(let error):
                self?.output?.throwError(error)
            }
        }
    }
    
    func removeCategory(_ category: CategoryEntity) {
        useCase.remove(category) { [weak self] result in
            guard case let .failure(error) = result else { return }
            self?.output?.throwError(error)
            self?.output?.removeCategoryDidFall(category)
        }
    }
}
