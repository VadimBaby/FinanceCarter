//
//  CategoriesFlowCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol CategoriesFlowCoordinatorOutput: AnyObject {
    func categoriesFlowCoordinatorDidStart(with viewController: UIViewController)
}

protocol CategoriesFlowCoordinatorInput: NavigationCoordinator {
    var delegate: CategoriesFlowCoordinatorOutput? { get set }
}

final class CategoriesFlowCoordinator: CategoriesFlowCoordinatorInput {
    weak var delegate: CategoriesFlowCoordinatorOutput?
    
    private let resolver: Resolver
    
    let navigationController: UINavigationController
    
    typealias CategoriesRouterAssembly = (_ navigationController: UINavigationController, _ resolver: Resolver) -> CategoriesRouterInput
    
    private let categoriesRouterAssembly: CategoriesRouterAssembly
    
    private var categoriesRouter: CategoriesRouterInput?
    
    init(
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        categoriesRouterAssembly: @escaping CategoriesRouterAssembly
    ) {
        self.categoriesRouterAssembly = categoriesRouterAssembly
        
        self.resolver = resolver
        
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func start() {
        categoriesRouter = categoriesRouterAssembly(navigationController, resolver)
        categoriesRouter?.delegate = self
        categoriesRouter?.open()
        delegate?.categoriesFlowCoordinatorDidStart(with: navigationController)
    }
}

extension CategoriesFlowCoordinator: CategoriesRouterOutput {
    
}
