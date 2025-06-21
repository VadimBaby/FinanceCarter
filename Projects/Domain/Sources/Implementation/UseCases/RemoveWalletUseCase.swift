//
//  RemoveWalletUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol RemoveWalletUseCaseProtocol: AnyObject {
    func execute(wallet: WalletEntity, completion: @escaping UpdateWalletCompletion)
}

public final class RemoveWalletUseCase: RemoveWalletUseCaseProtocol {
    private let repository: WalletsRepositoryProtocol
    
    public init(repository: WalletsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(wallet: WalletEntity, completion: @escaping UpdateWalletCompletion) {
        repository.remove(by: wallet.id) { result in
            switch result {
            case .success: completion(.success(wallet))
            case .failure(let error): completion(.failure(.repository(error)))
            }
        }
    }
}
