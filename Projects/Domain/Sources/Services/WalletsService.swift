//
//  WalletsService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Common

public final class WalletsService: WalletsUseCase {
    private let repository: WalletsRepository
    
    public init(repository: WalletsRepository) {
        self.repository = repository
    }
    
    public func fetchWallets(completion: @escaping WalletsUseCaseCompletionManyEntities) {
        repository.fetchWallets { result in
            switch result {
            case .success(let wallets):
                let sortedWallets = wallets.sortedByCreatedAt()
                completion(.success(sortedWallets))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func addWallet(title: String, balance: Double, completion: @escaping WalletsUseCaseCompletionOneEntity) {
        let wallet = WalletEntity(title: title, balance: balance)
        
        repository.addWallet(wallet) { result in
            switch result {
            case .success: completion(.success(wallet))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    public func removeWallet(_ wallet: WalletEntity, completion: @escaping WalletsUseCaseCompletionOneEntity) {
        repository.removeWallet(by: wallet.id) { result in
            switch result {
            case .success: completion(.success(wallet))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
