//
//  CategoriesFlowCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Common

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
    typealias CreateCategoryRouterAssembly = (_ navigationController: UINavigationController, _ resolver: Resolver) -> CreateCategoryRouterInput
    
    private let categoriesRouterAssembly: CategoriesRouterAssembly
    private let createCategoryRouterAssembly: CreateCategoryRouterAssembly
    
    private var categoriesRouter: CategoriesRouterInput?
    private var createCategoryRouter: CreateCategoryRouterInput?
    
    init(
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        categoriesRouterAssembly: @escaping CategoriesRouterAssembly,
        createCategoryRouterAssembly: @escaping CreateCategoryRouterAssembly
    ) {
        self.categoriesRouterAssembly = categoriesRouterAssembly
        self.createCategoryRouterAssembly = createCategoryRouterAssembly
        
        self.resolver = resolver
        
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    private var updateCategoriesViewClosure: VoidAction?
    
    func start() {
        defer { delegate?.categoriesFlowCoordinatorDidStart(with: navigationController) }
        openCategoriesScreen()
    }
}

// MARK: - Private Methods

private extension CategoriesFlowCoordinator {
    func openCategoriesScreen() {
        categoriesRouter = categoriesRouterAssembly(navigationController, resolver)
        categoriesRouter?.delegate = self
        categoriesRouter?.open()
    }
    
    func openCreateCategoryScreen() {
        createCategoryRouter = createCategoryRouterAssembly(navigationController, resolver)
        createCategoryRouter?.delegate = self
        createCategoryRouter?.open()
    }
    
    func closeCreateCategoryScreen() {
        createCategoryRouter?.close()
        createCategoryRouter = nil
        updateCategoriesViewClosure = nil
    }
}

// MARK: - CategoriesRouterOutput

extension CategoriesFlowCoordinator: CategoriesRouterOutput {
    func categoriesAddButtonDidPressed(updateCategoriesViewClosure: @escaping VoidAction) {
        self.updateCategoriesViewClosure = updateCategoriesViewClosure
        openCreateCategoryScreen()
    }
}

// MARK: - CreateCategoryRouterOutput

extension CategoriesFlowCoordinator: CreateCategoryRouterOutput {
    func createCategoryCloseButtonDidPressed() {
        closeCreateCategoryScreen()
    }
    
    func categoryDidAdded() {
        updateCategoriesViewClosure?()
        closeCreateCategoryScreen()
    }
}
