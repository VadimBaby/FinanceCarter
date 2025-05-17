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

final class DataSourcesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(WalletsLocalDataSource.self, factory: WalletsCoreDataSource.init)
        container.register(CategoriesLocalDataSource.self, factory: CategoriesCoreDataSource.init)
    }
}
