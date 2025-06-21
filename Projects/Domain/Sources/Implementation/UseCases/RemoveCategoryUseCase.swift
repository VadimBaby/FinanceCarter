//
//  RemoveCategoryUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol RemoveCategoryUseCaseProtocol: AnyObject {
    func execute(category: CategoryEntity, completion: @escaping UpdateCategoryCompletion)
}

public final class RemoveCategoryUseCase: RemoveCategoryUseCaseProtocol {
    private let repository: CategoriesRepositoryProtocol
    
    public init(repository: CategoriesRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(category: CategoryEntity, completion: @escaping UpdateCategoryCompletion) {
        repository.remove(by: category.id) { result in
            switch result {
            case .success: completion(.success(category))
            case .failure(let error): completion(.failure(.repository(error)))
            }
        }
    }
}

