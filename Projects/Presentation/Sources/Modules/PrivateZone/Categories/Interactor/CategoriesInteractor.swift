//
//  CategoriesInteractor.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Domain
import Foundation

protocol CategoriesInteractorOutput: AnyObject {
    func categoriesDidGet(_ categories: [CategoryEntity])
    func throwError(_ error: Error)
}

protocol CategoriesInteractorInput: AnyObject {
    var output: CategoriesInteractorOutput? { get set }
    
    func getCategories()
    func removeCategory(_ category: CategoryEntity)
    func addCategory()
}

final class CategoriesInteractor: CategoriesInteractorInput {
    weak var output: CategoriesInteractorOutput?
    
    private let useCase: CategoriesUseCase
    
    init(useCase: CategoriesUseCase) {
        self.useCase = useCase
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func getCategories() {
        useCase.fetchCategories { [weak self] result in
            switch result {
            case .success(let categories):
                self?.output?.categoriesDidGet(categories)
            case .failure(let error):
                self?.output?.throwError(error)
            }
        }
    }
    
    func removeCategory(_ category: CategoryEntity) {
        useCase.removeCategory(category) { [weak self] result in
            guard case let .failure(error) = result else { return }
            self?.output?.throwError(error)
        }
    }
    
#warning("need to remove it")
    func addCategory() {
        let title = UUID().uuidString
        useCase.addCategory(title: title, type: .income) { [weak self] result in
            switch result {
            case .success: self?.getCategories()
            case let .failure(error): self?.output?.throwError(error)
            }
        }
    }
}
