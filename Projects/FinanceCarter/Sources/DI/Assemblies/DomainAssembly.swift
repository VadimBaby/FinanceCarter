//
//  AppServicesAssemble.swift
//  FinanceCarter
//
//  Created by Вадим Мартыненко on 04.03.2025.
//

import Swinject
import Domain

final class DomainAssembly: Assembly {
    func assemble(container: Container) {
        container.register(OnboardingUseCase.self) { resolver, items in
            OnboardingService(settingsStorage: resolver.resolve(SettingsStorageProtocol.self)!, onboardingItems: items)
        }
        
        container.register(AccountUseCase.self) { resolver in
            AccountService(settingsStorage: resolver.resolve(SettingsStorageProtocol.self)!)
        }
        
//        container.register(WalletManagmentUseCase.self) { resolver in
//            WalletManagmentService(repository: resolver.resolve(WalletsRepository.self)!)
//        }
//        
//        container.register(CategoryManagmentUseCase.self) { resolver in
//            CategoryManagmentService(repository: resolver.resolve(CategoriesRepository.self)!)
//        }
//        
//        container.register(TransactionManagmentUseCase.self) { resolver in
//            TransactionManagmentService(repository: resolver.resolve(TransactionsRepository.self)!)
//        } // .implements(TransactionManaging.self)
//        
//        container.register(TransactionSectionManagmentUseCase.self) { resolver in
//            TransactionSectionManagmentService(
//                repository: resolver.resolve(TransactionSectionsRepository.self)!
//            )
//        }
//        
//        container.register(TransactionManaging.self) { resolver in
//            TransactionManager(
//                transactionsUseCase: resolver.resolve(TransactionManagmentUseCase.self)!,
//                transactionSectionsUseCase: resolver.resolve(TransactionSectionManagmentUseCase.self)!,
//                walletsUseCase: resolver.resolve(WalletManagmentUseCase.self)!
//            )
//        }
    }
}
