//
//  CategoriesService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class CategoryManagmentService: CategoryManagmentUseCase {
    private let repository: CategoriesRepository
    
    public init(repository: CategoriesRepository) {
        self.repository = repository
    }
    
    public func fetch(completion: @escaping FetchCategoryCompletion) {
        repository.fetch { result in
            switch result {
            case .success(let entities): completion(.success(entities))
            case .failure(let error): completion(.failure(.repository(error)))
            }
        }
    }
    
    public func create(title: String, emoji: String, type: CategoryType, completion: @escaping UpdateCategoryCompletion) {
        let category = CategoryEntity(title: title, emoji: emoji, type: type)
        
        repository.create(category) { result in
            switch result {
            case .success: completion(.success(category))
            case .failure(let error): completion(.failure(.repository(error)))
            }
        }
    }
    
    public func remove(_ category: CategoryEntity, completion: @escaping UpdateCategoryCompletion) {
        repository.remove(by: category.id) { result in
            switch result {
            case .success: completion(.success(category))
            case .failure(let error): completion(.failure(.repository(error)))
            }
        }
    }
}
