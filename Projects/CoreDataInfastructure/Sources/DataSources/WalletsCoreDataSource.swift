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
import Common

public final class WalletsCoreDataSource: CoreDataStore, WalletsLocalDataSource {
    public func fetchWallets() -> Result<[WalletEntity], Error> {
        do {
            let entites = try fetch(type: DBWallet.self)
            let domainEntities = WalletMapper.toDomain(from: entites)
            return .success(domainEntities)
        } catch {
            return .failure(error)
        }
    }
    
    public func addWallet(_ wallet: WalletEntity) -> OperationResult {
        let newWallet = DBWallet(context: store.viewContext)
        
        newWallet.id = wallet.id
        newWallet.title = wallet.title
        newWallet.balance = wallet.balance
        newWallet.createdAt = wallet.createdAt
        
        do {
            try saveContext()
            return .success
        } catch {
            return .failure(error)
        }
    }
    
    public func removeWallet(by id: UUID) -> OperationResult {
        do {
            let entities = try fetch(type: DBWallet.self)
            guard let entity = entities.first(where: { $0.id == id }) else { return .success }
            try delete(entity: entity)
            return .success
        } catch {
            return .failure(error)
        }
    }
}
