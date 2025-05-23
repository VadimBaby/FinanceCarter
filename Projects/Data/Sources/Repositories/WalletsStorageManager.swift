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
import Common

public final class WalletsStorageManager: WalletsRepository {
    private let localDataSource: WalletsLocalDataSource
    
    public init(localDataSource: WalletsLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    public func fetchWallets(completion: @escaping (_ result: Result<[WalletEntity], Error>) -> Void) {
        let result = localDataSource.fetchWallets()
        completion(result)
    }
    
    public func addWallet(_ wallet: WalletEntity, completion: @escaping OperationResultCompletion) {
        let result = localDataSource.addWallet(wallet)
        completion(result)
    }
    
    public func removeWallet(by id: UUID, completion: @escaping  OperationResultCompletion) {
        let result = localDataSource.removeWallet(by: id)
        completion(result)
    }
}
