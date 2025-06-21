//
//  MockCreateWalletUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class MockCreateWalletUseCase: CreateWalletUseCaseProtocol {
    public init() {}
    
    public func execute(title: String, balance: Double, completion: @escaping UpdateWalletCompletion) {
        let wallet = WalletEntity(title: title, balance: balance)
        completion(.success(wallet))
    }
}
