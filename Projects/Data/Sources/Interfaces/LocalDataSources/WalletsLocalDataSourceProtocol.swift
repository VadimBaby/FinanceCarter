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

public protocol WalletsLocalDataSourceProtocol: AnyObject {
    func fetchWallets() throws -> [Wallet]
    func addWallet(_ wallet: Wallet) throws
    func deleteWalletBy(id: UUID) throws
}
