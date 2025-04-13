//
//  StoragesAssembly.swift
//  FinanceCarter
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import Swinject
import Domain
import Data

final class StoragesAssemble: Assembly {
    func assemble(container: Container) {
        container.register(SettingsStorageProtocol.self, factory: UserDefaultsSettingsStorage.init)
    }
}
