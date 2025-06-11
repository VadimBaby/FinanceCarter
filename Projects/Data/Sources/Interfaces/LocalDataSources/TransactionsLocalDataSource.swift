//
//  TransactionsLocalDataSource.swift
//  Data
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Domain
import MyCommon

public protocol TransactionsLocalDataSource: AnyObject {
    func fetch() -> Result<[TransactionEntity], DataSourceError>
    func create(_ transaction: TransactionEntity) -> OperationResult<DataSourceError>
    func remove(by id: UUID) -> OperationResult<DataSourceError>
}
