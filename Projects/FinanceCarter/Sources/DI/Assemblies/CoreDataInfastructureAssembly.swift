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

final class CoreDataInfastructureAssembly: Assembly {
    func assemble(container: Container) {
        container.register(
            CoreDataStore.self,
            factory: CoreDataStoreStorageManager.init
        ).implements(CoreDataFetcher.self)
        
        container.register(AppSpecificCoreDataFetcher.self) { resolver in
            AppSpecificCoreDataFetcher(fetcher: resolver.resolve(CoreDataFetcher.self)!)
        }
        
        container.register(WalletRawDataFetcher.self) { resolver in
            WalletCoreDataFetcher(fetcher: resolver.resolve(AppSpecificCoreDataFetcher.self)!)
        }
        
        container.register(CategoryRawDataFetcher.self) { resolver in
            CategoryCoreDataFetcher(fetcher: resolver.resolve(AppSpecificCoreDataFetcher.self)!)
        }
        
        container.register(TransactionRawDataFetcher.self) { resolver in
            TransactionCoreDataFetcher(fetcher: resolver.resolve(AppSpecificCoreDataFetcher.self)!)
        }
        
        container.register(TransactionSectionRawDataFetcher.self) { resolver in
            TransactionSectionCoreDataFetcher(fetcher: resolver.resolve(AppSpecificCoreDataFetcher.self)!)
        }
        
        container.register(WalletsLocalDataSource.self) { resolver in
            WalletsCoreDataSource(
                walletRawDataFetcher: resolver.resolve(WalletRawDataFetcher.self)!,
                store: resolver.resolve(CoreDataStore.self)!
            )
        }
        
        container.register(CategoriesLocalDataSource.self) { resolver in
            CategoriesCoreDataSource(
                categoryRawDataFetcher: resolver.resolve(CategoryRawDataFetcher.self)!,
                store: resolver.resolve(CoreDataStore.self)!
            )
        }
        
        container.register(TransactionsLocalDataSource.self) { resolver in
            TransactionsCoreDataSource(
                transactionRawDataFetcher: resolver.resolve(TransactionRawDataFetcher.self)!,
                walletRawDataFetcher: resolver.resolve(WalletRawDataFetcher.self)!,
                categoryRawDataFetcher: resolver.resolve(CategoryRawDataFetcher.self)!,
                store: resolver.resolve(CoreDataStore.self)!
            )
        }
        
        container.register(TransactionSectionsLocalDataSource.self) { resolver in
            TransactionSectionsCoreDataSource(
                transactionSectionRawDataFetcher: resolver.resolve(TransactionSectionRawDataFetcher.self)!,
                transactionRawDataFetcher: resolver.resolve(TransactionRawDataFetcher.self)!,
                store: resolver.resolve(CoreDataStore.self)!
            )
        }
    }
}
