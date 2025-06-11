//
//  CategoriesUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import MyCommon

public typealias FetchCategoryCompletion = (_ result: Result<[CategoryEntity], DomainError>) -> Void
public typealias UpdateCategoryCompletion = (_ result: Result<CategoryEntity, DomainError>) -> Void

public protocol CategoryManagmentUseCase: AnyObject {
    func fetch(completion: @escaping FetchCategoryCompletion)
    func create(title: String, emoji: String, type: CategoryType, completion: @escaping UpdateCategoryCompletion)
    func remove(_ category: CategoryEntity, completion: @escaping UpdateCategoryCompletion)
}
