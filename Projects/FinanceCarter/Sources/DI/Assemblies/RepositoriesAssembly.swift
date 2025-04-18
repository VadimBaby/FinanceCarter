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
        container.register(WalletsRepository.self, factory: WalletsStorageManager.init)
    }
}
