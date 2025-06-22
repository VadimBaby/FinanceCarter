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
        
        container.register(FetchWalletsUseCaseProtocol.self) { resolver in
            FetchWalletsUseCase(repository: resolver.resolve(WalletsRepositoryProtocol.self)!)
        }
        
        container.register(CreateWalletUseCaseProtocol.self) { resolver in
            CreateWalletUseCase(repository: resolver.resolve(WalletsRepositoryProtocol.self)!)
        }
        
        container.register(RemoveWalletUseCaseProtocol.self) { resolver in
            RemoveWalletUseCase(repository: resolver.resolve(WalletsRepositoryProtocol.self)!)
        }
        
        container.register(IncreaseWalletBalanceUseCaseProtocol.self) { resolver in
            IncreaseWalletBalanceUseCase(repository: resolver.resolve(WalletsRepositoryProtocol.self)!)
        }
        
        container.register(FetchCategoriesUseCaseProtocol.self) { resolver in
            FetchCategoriesUseCase(repository: resolver.resolve(CategoriesRepositoryProtocol.self)!
            )
        }
        
        container.register(RemoveTransactionSectionUseCaseProtocol.self) { resolver in
            RemoveTransactionSectionUseCase(repository: resolver.resolve(TransactionSectionsRepositoryProtocol.self)!)
        }
        
        container.register(CreateCategoryUseCaseProtocol.self) { resolver in
            CreateCategoryUseCase(repository: resolver.resolve(CategoriesRepositoryProtocol.self)!)
        }
        
        container.register(RemoveTransactionUseCaseProtocol.self) { resolver in
            RemoveTransactionUseCase(repository: resolver.resolve(TransactionsRepositoryProtocol.self)!)
        }
        
        container.register(CreateTransactionSectionUseCaseProtocol.self) { resolver in
            CreateTransactionSectionUseCase(repository: resolver.resolve(TransactionSectionsRepositoryProtocol.self)!)
        }
        
        container.register(FetchOneTransactionSectionUseCaseProtocol.self) { resolver in
            FetchOneTransactionSectionUseCase(repository: resolver.resolve(TransactionSectionsRepositoryProtocol.self)!)
        }
        
        container.register(AddTransactionsToSectionUseCaseProtocol.self) { resolver in
            AddTransactionsToSectionUseCase(repository: resolver.resolve(TransactionSectionsRepositoryProtocol.self)!)
        }
        
        container.register(CreateTransactionUseCaseProtocol.self) { resolver in
            CreateTransactionUseCase(
                increaseWalletBalanceUseCase: resolver.resolve(IncreaseWalletBalanceUseCaseProtocol.self)!,
                fetchOneTransactionSectionUseCase: resolver.resolve(FetchOneTransactionSectionUseCaseProtocol.self)!,
                createTransactionSectionUseCase: resolver.resolve(CreateTransactionSectionUseCaseProtocol.self)!,
                addTransactionsToSectionUseCase: resolver.resolve(AddTransactionsToSectionUseCaseProtocol.self)!,
                repository: resolver.resolve(TransactionsRepositoryProtocol.self)!)
        }
        
        container.register(RemoveCategoryUseCaseProtocol.self) { resolver in
            RemoveCategoryUseCase(repository: resolver.resolve(CategoriesRepositoryProtocol.self)!)
        }
        
        container.register(FetchTransactionsUseCaseProtocol.self) { resolver in
            FetchTransactionsUseCase(repository: resolver.resolve(TransactionsRepositoryProtocol.self)!)
        }
        
        container.register(FetchTransactionSectionsUseCaseProtocol.self) { resolver in
            FetchTransactionSectionsUseCase(repository: resolver.resolve(TransactionSectionsRepositoryProtocol.self)!)
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
