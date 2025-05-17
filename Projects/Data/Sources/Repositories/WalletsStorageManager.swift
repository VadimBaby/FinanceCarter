//
//  WalletStorageManager.swift
//  Data
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Domain

public final class WalletsStorageManager: WalletsRepository {
    private let localDataSource: WalletsLocalDataSourceProtocol
    
    public init(localDataSource: WalletsLocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }
    
    public func fetchWallets() throws -> [Wallet] {
        return try localDataSource.fetchWallets()
    }
    
    public func addWallet(_ wallet: Wallet) throws {
        try localDataSource.addWallet(wallet)
    }
    
    public func deleteWalletBy(id: UUID) throws {
        try localDataSource.deleteWalletBy(id: id)
    }
}
