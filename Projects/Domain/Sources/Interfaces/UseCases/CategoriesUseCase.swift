//
//  CategoriesUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Common

public typealias CategoriesUseCaseCompletionManyEntities = (_ result: Result<[CategoryEntity], Error>) -> Void
public typealias CategoriesUseCaseCompletionOneEntities = (_ result: Result<CategoryEntity, Error>) -> Void

public protocol CategoriesUseCase: AnyObject {
    func fetchCategories(completion: @escaping CategoriesUseCaseCompletionManyEntities)
    func addCategory(title: String, type: CategoryType, completion: @escaping CategoriesUseCaseCompletionOneEntities)
    func removeCategory(_ category: CategoryEntity, completion: @escaping CategoriesUseCaseCompletionOneEntities)
}
