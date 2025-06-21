//
//  CreateWalletUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol CreateWalletUseCaseProtocol: AnyObject {
    func execute(title: String, balance: Double, completion: @escaping UpdateWalletCompletion)
}

public final class CreateWalletUseCase: CreateWalletUseCaseProtocol {
    private let repository: WalletsRepositoryProtocol
    
    public init(repository: WalletsRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(title: String, balance: Double, completion: @escaping UpdateWalletCompletion) {
        let wallet = WalletEntity(title: title, balance: balance)
        
        repository.create(wallet) { result in
            switch result {
            case .success: completion(.success(wallet))
            case .failure(let error): completion(.failure(.repository(error)))
            }
        }
    }
}
