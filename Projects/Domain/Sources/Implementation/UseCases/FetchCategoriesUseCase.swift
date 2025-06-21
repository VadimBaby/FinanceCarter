//
//  FetchCategoriesUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol FetchCategoriesUseCaseProtocol: AnyObject {
    func execute(completion: @escaping FetchCategoryCompletion)
}

public final class FetchCategoriesUseCase: FetchCategoriesUseCaseProtocol {
    private let repository: CategoriesRepository
    
    public init(repository: CategoriesRepository) {
        self.repository = repository
    }
    
    public func execute(completion: @escaping FetchCategoryCompletion) {
        repository.fetch { result in
            switch result {
            case .success(let entities): completion(.success(entities))
            case .failure(let error): completion(.failure(.repository(error)))
            }
        }
    }
}
