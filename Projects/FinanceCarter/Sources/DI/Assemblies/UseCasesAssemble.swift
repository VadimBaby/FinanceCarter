//
//  AppServicesAssemble.swift
//  FinanceCarter
//
//  Created by Вадим Мартыненко on 04.03.2025.
//

import Swinject
import Domain

final class UseCasesAssemble: Assembly {
    func assemble(container: Container) {
        container.register(OnboardingUseCase.self) { resolver, items in
            OnboardingService(repository: resolver.resolve(KeyValueStorageRepository.self)!, onboardingItems: items)
        }
    }
}
