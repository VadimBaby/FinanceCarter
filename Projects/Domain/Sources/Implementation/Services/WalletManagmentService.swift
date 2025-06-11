//
//  WalletsService.swift
//  Domain
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import MyCommon

public final class WalletManagmentService: WalletManagmentUseCase {
    private let repository: WalletsRepository
    
    public init(repository: WalletsRepository) {
        self.repository = repository
    }
    
    public func fetch(completion: @escaping FetchWalletsCompletion) {
        repository.fetch { result in
            switch result {
            case let .success(entities): completion(.success(entities))
            case let .failure(error): completion(.failure(.repository(error)))
            }
        }
    }
    
    public func create(title: String, balance: Double, completion: @escaping UpdateWalletCompletion) {
        let wallet = WalletEntity(title: title, balance: balance)
        
        repository.create(wallet) { result in
            switch result {
            case .success: completion(.success(wallet))
            case .failure(let error): completion(.failure(.repository(error)))
            }
        }
    }
    
    public func remove(_ wallet: WalletEntity, completion: @escaping UpdateWalletCompletion) {
        repository.remove(by: wallet.id) { result in
            switch result {
            case .success: completion(.success(wallet))
            case .failure(let error): completion(.failure(.repository(error)))
            }
        }
    }
    
    public func increaseBalance(by amount: Double, of wallet: WalletEntity, completion: @escaping UpdateWalletCompletion) {
        let balance = wallet.balance + amount
        
        repository.set(balance: balance, for: wallet) { result in
            switch result {
            case .success:
                let increasedBalanceWallet = wallet.copyWith(balance: balance)
                completion(.success(increasedBalanceWallet))
            case let .failure(error):
                completion(.failure(.repository(error)))
            }
        }
    }
}
