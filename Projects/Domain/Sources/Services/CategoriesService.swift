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
        repository.fetchCategories { result in
            switch result {
            case .success(let categories):
                let sortedCategories = categories.sortedByCreatedAt()
                completion(.success(sortedCategories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func addCategory(title: String, emoji: String, type: CategoryType, completion: @escaping CategoriesUseCaseCompletionOneEntity) {
        let category = CategoryEntity(title: title, emoji: emoji, type: type)
        
        repository.addCategory(category) { result in
            switch result {
            case .success: completion(.success(category))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    public func removeCategory(_ category: CategoryEntity, completion: @escaping CategoriesUseCaseCompletionOneEntity) {
        repository.removeCategory(by: category.id) { result in
            switch result {
            case .success: completion(.success(category))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
