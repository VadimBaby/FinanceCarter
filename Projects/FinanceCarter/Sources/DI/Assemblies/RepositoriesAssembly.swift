//
//  CoreServiciesAssemble.swift
//  FinanceCarter
//
//  Created by Вадим Мартыненко on 28.02.2025.
//

import Swinject
import Domain
import Data

final class RepositoriesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(WalletsRepository.self) { resolver in
            WalletsStorageManager(
                localDataSource: resolver.resolve(WalletsLocalDataSource.self)!
            )
        }
        
        container.register(CategoriesRepository.self) { resolver in
            CategoriesStorageManager(
                localDataSource: resolver.resolve(CategoriesLocalDataSource.self)!
            )
        }
        
        container.register(TransactionsRepository.self) { resolver in
            TransactionsStorageManager(
                localDataSource: resolver.resolve(TransactionsLocalDataSource.self)!
            )
        }
    }
}
