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
import MyCommon

public protocol CategoriesLocalDataSource: AnyObject {
    func fetch() -> Result<[CategoryEntity], DataSourceError>
    func create(_ category: CategoryEntity) -> OperationResult<DataSourceError>
    func remove(by id: UUID) -> OperationResult<DataSourceError>
}
