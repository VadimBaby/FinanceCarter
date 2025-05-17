//
//  AppServicesAssemble.swift
//  FinanceCarter
//
//  Created by Вадим Мартыненко on 04.03.2025.
//

import Swinject
import Domain

final class UseCasesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(OnboardingUseCase.self) { resolver, items in
            OnboardingService(settingsStorage: resolver.resolve(SettingsStorageProtocol.self)!, onboardingItems: items)
        }
        
        container.register(AccountUseCase.self) { resolver in
            AccountService(settingsStorage: resolver.resolve(SettingsStorageProtocol.self)!)
        }
        
        container.register(WalletsUseCase.self) { resolver in
            WalletsService(repository: resolver.resolve(WalletsRepository.self)!)
        }
        
        container.register(CategoriesUseCase.self) { resolver in
            CategoriesService(repository: resolver.resolve(CategoriesRepository.self)!)
        }
    }
}
