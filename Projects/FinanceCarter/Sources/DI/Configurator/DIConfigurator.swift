//
//  DIConfigurator.swift
//  FinanceCarter
//
//  Created by Вадим Мартыненко on 27.02.2025.
//

import Swinject
import Presentation

typealias PresentationResolver = Presentation.Resolver

extension Container: @retroactive PresentationResolver {}

final class DIConfigurator {
    static func configure(with assemblies: [any Assembly]) -> PresentationResolver {
        let container = Container()
        let assembler = Assembler(assemblies, container: container)
        
        guard let resolver = assembler.resolver as? PresentationResolver else {
            fatalError("Can't create resolver")
        }
        
        return resolver
    }
}
