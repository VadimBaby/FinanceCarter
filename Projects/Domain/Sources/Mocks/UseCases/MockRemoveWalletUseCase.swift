//
//  MockRemoveWalletUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public final class MockRemoveWalletUseCase: RemoveWalletUseCaseProtocol {
    public init() {}
    
    public func execute(wallet: WalletEntity, completion: @escaping UpdateWalletCompletion) {
        completion(.success(wallet))
    }
}
