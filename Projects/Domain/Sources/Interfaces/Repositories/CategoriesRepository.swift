//
//  CategoriesRepository.swift
//  Domain
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Common

public protocol CategoriesRepository: AnyObject {
    func fetchCategories(completion: @escaping (_ result: Result<[CategoryEntity], Error>) -> Void)
    func addCategory(_ category: CategoryEntity, completion: @escaping OperationResultCompletion)
    func removeCategory(by id: UUID, completion: @escaping OperationResultCompletion)
}
