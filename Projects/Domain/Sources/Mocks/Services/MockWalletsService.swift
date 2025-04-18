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
    
    private var wallets: [Wallet] = [
        Wallet(title: "Tinkoff", balance: 1799)
    ]
    
    public func fetchWallets() -> Result<[Wallet], Error> {
        return .success(wallets)
    }
    
    @discardableResult
    public func addWallet(
        title: String,
        balance: Double
    ) -> OperationResult {
        let wallet = Wallet(title: title, balance: balance)
        wallets.append(wallet)
        return .success
    }
}
