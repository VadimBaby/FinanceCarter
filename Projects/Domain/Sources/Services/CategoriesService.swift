//
//  CategoriesService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class CategoriesService: CategoriesUseCase {
    private let repository: CategoriesRepository
    
    public init(repository: CategoriesRepository) {
        self.repository = repository
    }
    
    public func fetchCategories(completion: @escaping CategoriesUseCaseCompletionManyEntities) {
        repository.fetchCategories(completion: completion)
    }
    
    public func addCategory(title: String, type: CategoryType, completion: @escaping CategoriesUseCaseCompletionOneEntities) {
        let category = CategoryEntity(title: title, type: type)
        
        repository.addCategory(category) { result in
            switch result {
            case .success: completion(.success(category))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    public func removeCategory(_ category: CategoryEntity, completion: @escaping CategoriesUseCaseCompletionOneEntities) {
        repository.removeCategory(by: category.id) { result in
            switch result {
            case .success: completion(.success(category))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
