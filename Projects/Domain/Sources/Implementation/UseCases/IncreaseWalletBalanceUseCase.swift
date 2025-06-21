//
//  IncreaseBalanceUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol IncreaseWalletBalanceUseCaseProtocol: AnyObject {
    func execute(
        amount: Double,
        wallet: WalletEntity,
        completion: @escaping UpdateWalletCompletion
    )
}

public final class IncreaseWalletBalanceUseCase: IncreaseWalletBalanceUseCaseProtocol {
    private let repository: WalletsRepositoryProtocol
    
    public init(repository: WalletsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(
        amount: Double,
        wallet: WalletEntity,
        completion: @escaping UpdateWalletCompletion
    ) {
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
