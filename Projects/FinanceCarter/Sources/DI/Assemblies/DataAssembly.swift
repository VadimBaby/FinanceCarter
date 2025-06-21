//
//  CoreServiciesAssemble.swift
//  FinanceCarter
//
//  Created by Вадим Мартыненко on 28.02.2025.
//

import Swinject
import Domain
import Data

final class DataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(WalletsRepository.self) { resolver in
            WalletsRepository(
                localDataSource: resolver.resolve(WalletsLocalDataSource.self)!
            )
        }
        
        container.register(CategoriesRepository.self) { resolver in
            CategoriesRepository(
                localDataSource: resolver.resolve(CategoriesLocalDataSource.self)!
            )
        }
        
        container.register(TransactionsRepository.self) { resolver in
            TransactionsRepository(
                localDataSource: resolver.resolve(TransactionsLocalDataSource.self)!
            )
        }
        
        container.register(TransactionSectionsRepository.self) { resolver in
            TransactionSectionsRepository(
                localDataSource: resolver.resolve(TransactionSectionsLocalDataSource.self)!
            )
        }
        
        container.register(SettingsStorageProtocol.self, factory: UserDefaultsSettingsStorage.init)
    }
}
