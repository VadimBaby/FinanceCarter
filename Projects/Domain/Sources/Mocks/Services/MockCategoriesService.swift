//
//  MockCategoriesService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class MockCategoriesService: CategoriesUseCase {
    private var categories: [CategoryEntity] = [
        .init(id: .init(), title: "Транспорт", type: .spending, createdAt: .now)
    ]
    
    public init() {}
    
    public func fetchCategories(completion: @escaping CategoriesUseCaseCompletionManyEntities) {
        completion(.success(categories))
    }
    
    public func addCategory(title: String, type: CategoryType, completion: @escaping CategoriesUseCaseCompletionOneEntities) {
        let category = CategoryEntity(title: title, type: type)
        self.categories.append(category)
        completion(.success(category))
    }
    
    public func removeCategory(_ category: CategoryEntity, completion: @escaping CategoriesUseCaseCompletionOneEntities) {
        self.categories.removeAll(where: { $0.id == category.id })
        completion(.success(category))
    }
}
