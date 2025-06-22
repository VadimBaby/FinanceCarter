//
//  WalletsLocalDataSource.swift
//  CoreDataInfastructure
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

// swiftlint:disable:next foundation_using
import Foundation
import Domain
import Data
import MyCommon
import MyCoreDataWrapper

public final class WalletsCoreDataSource: WalletsLocalDataSource {
    private let store: CoreDataStorage
    
    public init(store: CoreDataStorage) {
        self.store = store
    }
    
    public func fetch() -> Result<[WalletEntity], DataSourceError> {
        do {
            let entites = try store.fetch(type: DBWallet.self)
            let domainEntities = WalletMapper.toDomain(from: entites)
            return .success(domainEntities)
        } catch {
            return .failure(.cannotFetch)
        }
    }
    
    public func create(_ wallet: WalletEntity) -> OperationResult<DataSourceError> {
        do {
            try store.create(type: DBWallet.self) { entity in
                entity.id = wallet.id
                entity.title = wallet.title
                entity.balance = wallet.balance
                entity.createdAt = wallet.createdAt
            }
            
            return .success
        } catch {
            return .failure(.cannotCreate)
        }
    }
    
    public func remove(by id: UUID) -> OperationResult<DataSourceError> {
        do {
            guard let entity = try store.fetch(by: id, type: DBWallet.self) else { return .success }
            try store.delete(entity: entity)
            return .success
        } catch {
            return .failure(.cannotRemove)
        }
    }
    
    public func set(balance: Double, for wallet: WalletEntity) -> OperationResult<DataSourceError> {
        do {
            guard let entity = try store.fetch(by: wallet.id, type: DBWallet.self) else { return .success }
            try store.update(entity: entity) {
                $0.balance = balance
            }
            return .success
        } catch {
            return .failure(.cannotUpdate)
        }
    }
}
