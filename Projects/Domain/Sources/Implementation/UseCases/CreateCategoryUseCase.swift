//
//  CreateCategoryUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol CreateCategoryUseCaseProtocol: AnyObject {
    func execute(
        title: String,
        emoji: String,
        type: CategoryType,
        completion: @escaping UpdateCategoryCompletion
    )
}

public final class CreateCategoryUseCase: CreateCategoryUseCaseProtocol {
    private let repository: CategoriesRepositoryProtocol
    
    public init(repository: CategoriesRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(
        title: String,
        emoji: String,
        type: CategoryType,
        completion: @escaping UpdateCategoryCompletion
    ) {
        let category = CategoryEntity(title: title, emoji: emoji, type: type)
        
        repository.create(category) { result in
            switch result {
            case .success: completion(.success(category))
            case .failure(let error): completion(.failure(.repository(error)))
            }
        }
    }
}
