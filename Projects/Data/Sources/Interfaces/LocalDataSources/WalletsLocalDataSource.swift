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
import Common

public protocol WalletsLocalDataSource: AnyObject {
    func fetchWallets() -> Result<[WalletEntity], Error>
    func addWallet(_ wallet: WalletEntity) -> OperationResult<Error>
    func removeWallet(by id: UUID) -> OperationResult<Error>
}
