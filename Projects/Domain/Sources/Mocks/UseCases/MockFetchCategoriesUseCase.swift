//
//  MockFetchCategoriesUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class MockFetchCategoriesUseCase: FetchCategoriesUseCaseProtocol {
    public init() {}
    
    public func execute(completion: @escaping FetchCategoryCompletion) {
        completion(.success([
            .mock
        ]))
    }
}
