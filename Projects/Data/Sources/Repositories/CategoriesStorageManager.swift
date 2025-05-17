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
import Common

public final class CategoriesStorageManager: CategoriesRepository {
    private let localDataSource: CategoriesLocalDataSource
    
    public init(localDataSource: CategoriesLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    public func fetchCategories(completion: @escaping (_ result: Result<[CategoryEntity], Error>) -> Void) {
        let result = localDataSource.fetchCategories()
        completion(result)
    }
    
    public func addCategory(_ category: CategoryEntity, completion: @escaping OperationResultCompletion) {
        let result = localDataSource.addCategory(category)
        completion(result)
    }
    
    public func removeCategory(by id: UUID, completion: @escaping OperationResultCompletion) {
        let result = localDataSource.removeCategory(by: id)
        completion(result)
    }
}
