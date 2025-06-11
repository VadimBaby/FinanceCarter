//
//  MockCategoriesService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class MockCategoryManagmentService: CategoryManagmentUseCase {
    private var categories: [CategoryEntity] = [.mock]
    
    public init() {}
    
    public func fetch(completion: @escaping FetchCategoryCompletion) {
        completion(.success(categories))
    }
    
    public func create(title: String, emoji: String, type: CategoryType, completion: @escaping UpdateCategoryCompletion) {
        let category = CategoryEntity(title: title, emoji: emoji, type: type)
        self.categories.append(category)
        completion(.success(category))
    }
    
    public func remove(_ category: CategoryEntity, completion: @escaping UpdateCategoryCompletion) {
        self.categories.removeAll(where: { $0.id == category.id })
        completion(.success(category))
    }
}
