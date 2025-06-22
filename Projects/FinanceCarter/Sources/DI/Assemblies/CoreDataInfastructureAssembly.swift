//
//  DataStoresAssembly.swift
//  FinanceCarter
//
//  Created by Вадим Мартыненко on 17.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import CoreDataInfastructure
import Data
import Swinject
import MyCoreDataWrapper

final class CoreDataInfastructureAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CoreDataStorage.self) {
            CoreDataStorage(
                model: CoreDataInfastructureConstants.MODEL,
                bundle: CoreDataInfastructureConstants.BUNDLE
            )
        }
        
        container.register(WalletsLocalDataSource.self) { resolver in
            WalletsCoreDataSource(
                store: resolver.resolve(CoreDataStorage.self)!
            )
        }
        
        container.register(CategoriesLocalDataSource.self) { resolver in
            CategoriesCoreDataSource(
                store: resolver.resolve(CoreDataStorage.self)!
            )
        }
        
        container.register(TransactionsLocalDataSource.self) { resolver in
            TransactionsCoreDataSource(
                store: resolver.resolve(CoreDataStorage.self)!
            )
        }
        
        container.register(TransactionSectionsLocalDataSource.self) { resolver in
            TransactionSectionsCoreDataSource(
                store: resolver.resolve(CoreDataStorage.self)!
            )
        }
    }
}
