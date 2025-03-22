//
//  Container.swift
//  FinanceCarter
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import Swinject

extension Container {
    @discardableResult
    func register<Service>(_ serviceType: Service.Type, factory: @escaping () -> Service) -> ServiceEntry<Service> {
        register(serviceType) { _ in
            factory()
        }
    }
}
