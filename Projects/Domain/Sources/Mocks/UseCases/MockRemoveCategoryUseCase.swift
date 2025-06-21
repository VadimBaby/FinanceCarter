//
//  MockRemoveCategoryUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class MockRemoveCategoryUseCase: RemoveCategoryUseCaseProtocol {
    public init() {}
    
    public func execute(category: CategoryEntity, completion: @escaping UpdateCategoryCompletion) {
        completion(.success(category))
    }
}
