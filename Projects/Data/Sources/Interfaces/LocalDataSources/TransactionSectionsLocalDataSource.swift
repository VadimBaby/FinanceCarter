//
//  TransactionSectionsLocalDataSource.swift
//  Data
//
//  Created by Вадим Мартыненко on 08.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Domain
import MyCommon

public protocol TransactionSectionsLocalDataSource: AnyObject {
    func fetch() -> Result<[TransactionSectionEntity], DataSourceError>
    func fetch(by date: Date) -> Result<TransactionSectionEntity, DataSourceError>
    func create(_ section: TransactionSectionEntity) -> OperationResult<DataSourceError>
    func remove(by id: UUID) -> OperationResult<DataSourceError>
    func add(transactions: [TransactionEntity], to section: TransactionSectionEntity) -> OperationResult<DataSourceError>
}
