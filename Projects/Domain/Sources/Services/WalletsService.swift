//
//  WalletsService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Common

public final class WalletsService: WalletsUseCase {
    private let repository: WalletsRepository
    
    public init(repository: WalletsRepository) {
        self.repository = repository
    }
    
    public func fetchWallets() -> Result<[Wallet], Error> {
        do {
            let wallets = try repository.fetchWallets()
            return .success(wallets)
        } catch {
            return .failure(error)
        }
    }
    
    @discardableResult
    public func addWallet(
        title: String,
        balance: Double
    ) -> Result<Wallet, Error> {
        let wallet = Wallet(title: title, balance: balance)
        
        do {
            try repository.addWallet(from: wallet)
            return .success(wallet)
        } catch {
            return .failure(error)
        }
    }
}
