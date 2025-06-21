//
//  WalletStorageManager.swift
//  Data
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Domain
import MyCommon

public final class WalletsRepository: WalletsRepositoryProtocol {
    private let localDataSource: WalletsLocalDataSource
    
    public init(localDataSource: WalletsLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    public func fetch(completion: @escaping (_ result: Result<[WalletEntity], DataError>) -> Void) {
        let result = localDataSource.fetch()
        switch result {
        case let .success(entities): completion(.success(entities))
        case let .failure(error): completion(.failure(error.toDataError()))
        }
    }
    
    public func create(
        _ wallet: WalletEntity,
        completion: @escaping OperationResultCompletionWithDataError
    ) {
        let result = localDataSource.create(wallet)
        switch result {
        case .success: completion(.success)
        case let .failure(error): completion(.failure(error.toDataError()))
        }
    }
    
    public func remove(
        by id: UUID,
        completion: @escaping OperationResultCompletionWithDataError
    ) {
        let result = localDataSource.remove(by: id)
        switch result {
        case .success: completion(.success)
        case let .failure(error): completion(.failure(error.toDataError()))
        }
    }
    
    public func set(
        balance: Double,
        for wallet: WalletEntity,
        completion: @escaping OperationResultCompletionWithDataError
    ) {
        let result = localDataSource.set(balance: balance, for: wallet)
        switch result {
        case .success: completion(.success)
        case let .failure(error): completion(.failure(error.toDataError()))
        }
    }
}
