//
//  WalletsLocalDataSourceProtocol.swift
//  Data
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Domain
import MyCommon

public protocol WalletsLocalDataSource: AnyObject {
    func fetch() -> Result<[WalletEntity], DataSourceError>
    func create(_ wallet: WalletEntity) -> OperationResult<DataSourceError>
    func remove(by id: UUID) -> OperationResult<DataSourceError>
    func set(balance: Double, for wallet: WalletEntity) -> OperationResult<DataSourceError>
}
