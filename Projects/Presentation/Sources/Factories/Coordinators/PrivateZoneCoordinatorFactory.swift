//
//  PrivateZoneCoordinatorFactory.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.
//

import UIKit

final class PrivateZoneCoordinatorFactory {
    private init() {}
    
    static func create(
        window: UIWindow,
        resolver: Resolver
    ) -> PrivateZoneCoordinatorInput {
        PrivateZoneCoordinator(
            window: window,
            resolver: resolver,
            homeCoordinatorAssembly: HomeCoordinatorFactory.create,
            categoriesCoordinatorAssembly: CategoriesCoordinatorFactory.create,
            transactionsCoordinatorAssembly: TransactionsCoordinatorFactory.create,
            walletsCoordinatorAssembly: WalletsCoordinatorFactory.create,
            profileCoordinatorAssembly: ProfileCoordinatorFactory.create
        )
    }
}
