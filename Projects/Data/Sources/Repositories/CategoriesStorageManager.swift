//
//  CategoriesStorageManager.swift
//  Data
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Domain
import MyCommon

public final class CategoriesStorageManager: CategoriesRepository {
    private let localDataSource: CategoriesLocalDataSource
    
    public init(localDataSource: CategoriesLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    public func fetch(completion: @escaping (_ result: Result<[CategoryEntity], DataError>) -> Void) {
        let result = localDataSource.fetch()
        switch result {
        case let .success(entities): completion(.success(entities))
        case let .failure(error): completion(.failure(error.toDataError()))
        }
    }
    
    public func create(
        _ category: CategoryEntity,
        completion: @escaping OperationResultCompletionWithDataError
    ) {
        let result = localDataSource.create(category)
        switch result {
        case .success: completion(.success)
        case .failure(let error): completion(.failure(error.toDataError()))
        }
    }
    
    public func remove(by id: UUID, completion: @escaping OperationResultCompletionWithDataError) {
        let result = localDataSource.remove(by: id)
        switch result {
        case .success: completion(.success)
        case .failure(let error): completion(.failure(error.toDataError()))
        }
    }
}
