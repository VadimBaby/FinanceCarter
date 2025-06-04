//
//  MockCategoriesService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class MockCategoriesService: CategoriesUseCase {
    private var categories: [CategoryEntity] = [.mock]
    
    public init() {}
    
    public func fetchCategories(completion: @escaping CategoriesUseCaseCompletionManyEntities) {
        completion(.success(categories))
    }
    
    public func addCategory(title: String, emoji: String, type: CategoryType, completion: @escaping CategoriesUseCaseCompletionOneEntity) {
        let category = CategoryEntity(title: title, emoji: emoji, type: type)
        self.categories.append(category)
        completion(.success(category))
    }
    
    public func removeCategory(_ category: CategoryEntity, completion: @escaping CategoriesUseCaseCompletionOneEntity) {
        self.categories.removeAll(where: { $0.id == category.id })
        completion(.success(category))
    }
}
