//
//  MockWalletsService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Common

public final class MockWalletsService: WalletsUseCase {
    public init() { }
    
    private var wallets: [WalletEntity] = [
        WalletEntity(title: "Tinkoff", balance: 1799)
    ]
    
    public func fetchWallets(completion: @escaping WalletsUseCaseCompletionManyEntities) {
        completion(.success(wallets))
    }
    
    public func addWallet(title: String, balance: Double, completion: @escaping WalletsUseCaseCompletionOneEntity) {
        let wallet = WalletEntity(title: title, balance: balance)
        wallets.append(wallet)
        completion(.success(wallet))
    }
    
    public func removeWallet(_ wallet: WalletEntity, completion: @escaping WalletsUseCaseCompletionOneEntity) {
        wallets.removeAll(where: { $0.id == wallet.id })
        completion(.success(wallet))
    }
}
