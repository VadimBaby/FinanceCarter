//
//  MockCreateCategoryUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class MockCreateCategoryUseCase: CreateCategoryUseCaseProtocol {
    public init() {}
    public func execute(title: String, emoji: String, type: CategoryType, completion: @escaping UpdateCategoryCompletion) {
        let category = CategoryEntity(title: title, emoji: emoji, type: type)
        
        completion(.success(category))
    }
}
