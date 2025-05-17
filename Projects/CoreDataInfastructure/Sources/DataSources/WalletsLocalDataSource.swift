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

public final class WalletsLocalDataSource: CoreDataStore, WalletsLocalDataSourceProtocol {
    public func fetchWallets() throws -> [Wallet] {
        let entites = try fetch(type: DBWallet.self)
        return WalletMapper.toDomain(from: entites)
    }
    
    public func addWallet(_ wallet: Wallet) throws {
        let newWallet = DBWallet(context: store.viewContext)
        
        newWallet.id = wallet.id
        newWallet.title = wallet.title
        newWallet.balance = wallet.balance
        newWallet.createdAt = wallet.createdAt
        
        try saveContext()
    }
    
    public func deleteWalletBy(id: UUID) throws {
        let entities = try fetch(type: DBWallet.self)
        
        guard let entity = entities.first(where: { $0.id == id }) else { return }
        
        try delete(entity: entity)
    }
}
