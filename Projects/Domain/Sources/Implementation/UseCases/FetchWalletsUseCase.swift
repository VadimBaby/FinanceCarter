//
//  FetchWalletUseCase.swift
//  Domain
//
//  Created by Вадим Мартыненко on 21.06.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

public protocol FetchWalletsUseCaseProtocol: AnyObject {
    func execute(completion: @escaping FetchWalletsCompletion)
}

public final class FetchWalletsUseCase: FetchWalletsUseCaseProtocol {
    private let repository: WalletsRepository
    
    public init(repository: WalletsRepository) {
        self.repository = repository
    }
    
    public func execute(completion: @escaping FetchWalletsCompletion) {
        repository.fetch { result in
            switch result {
            case let .success(entities): completion(.success(entities))
            case let .failure(error): completion(.failure(.repository(error)))
            }
        }
    }
}
