//
//  CategoriesLocalDataSourceProtocol.swift
//  Data
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Domain
import Common

public protocol CategoriesLocalDataSource: AnyObject {
    func fetchCategories() -> Result<[CategoryEntity], Error>
    func addCategory(_ category: CategoryEntity) -> OperationResult
    func removeCategory(by id: UUID) -> OperationResult
}
