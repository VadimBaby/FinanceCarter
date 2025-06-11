//
//  MockWalletsService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import MyCommon

public final class MockWalletManagmentService: WalletManagmentUseCase {
    public init() { }
    
    private var wallets: [WalletEntity] = [
        WalletEntity(title: "Tinkoff", balance: 1799)
    ]
    
    public func fetch(completion: @escaping FetchWalletsCompletion) {
        completion(.success(wallets))
    }
    
    public func create(title: String, balance: Double, completion: @escaping UpdateWalletCompletion) {
        let wallet = WalletEntity(title: title, balance: balance)
        wallets.append(wallet)
        completion(.success(wallet))
    }
    
    public func remove(_ wallet: WalletEntity, completion: @escaping UpdateWalletCompletion) {
        wallets.removeAll(where: { $0.id == wallet.id })
        completion(.success(wallet))
    }
    
    public func increaseBalance(by amount: Double, of wallet: WalletEntity, completion: @escaping UpdateWalletCompletion) {
        guard let index = wallets.firstIndex(where: { $0.id == wallet.id }) else { completion(.success(wallet)); return  }
        wallets[index] = wallet.copyWith(balance: wallet.balance + amount)
    }
}
