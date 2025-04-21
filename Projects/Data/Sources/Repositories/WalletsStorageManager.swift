//
//  WalletStorageManager.swift
//  Data
//
//  Created by Вадим Мартыненко on 18.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import CoreDataInfastructure
import CoreData
import Domain

public final class WalletsStorageManager: CoreDataStorageManager, WalletsRepository {
    public func fetchWallets() throws -> [Wallet] {
        let entites = try fetch(type: DBWallet.self)
        return WalletMapper.toDomain(from: entites)
    }
    
    public func addWallet(from domainEntity: Wallet) throws {
        let newWallet = DBWallet(context: store.viewContext)
        
        newWallet.id = domainEntity.id
        newWallet.title = domainEntity.title
        newWallet.balance = domainEntity.balance
        newWallet.createdAt = domainEntity.createdAt
        
        try saveContext()
    }
}
