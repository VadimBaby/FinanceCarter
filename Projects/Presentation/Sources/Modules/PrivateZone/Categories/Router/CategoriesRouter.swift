//
//  CategoriesCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import MyCommon

protocol CategoriesRouterOutput: AnyObject {
    func categoriesAddButtonDidPressed(updateCategoriesViewClosure: @escaping VoidAction)
}

protocol CategoriesRouterInput: Router {
    var delegate: CategoriesRouterOutput? { get set }
    
    typealias ModuleAssembly = (_ router: CategoriesPresenterOutput, _ resolver: Resolver) -> CategoriesViewInput & UIViewController
    
    var moduleAssembly: ModuleAssembly? { get set }
    
    func open()
}

final class CategoriesRouter: CategoriesRouterInput {
    weak var delegate: CategoriesRouterOutput?
    
    private let resolver: Resolver
    
    let navigationController: UINavigationController
    
    typealias CategoriesAssembly = (_ coordinator: CategoriesPresenterOutput, _ resolver: Resolver) -> CategoriesViewInput & UIViewController
    
    var moduleAssembly: ModuleAssembly?
    
    init(
        navigationController: UINavigationController,
        resolver: Resolver
    ) {
        self.resolver = resolver
        
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func open() {
        guard let module = moduleAssembly?(self, resolver) else { fatalError("moduleAssembly is nil in \(self)") }
        navigationController.pushViewController(module, animated: true)
    }
}

extension CategoriesRouter: CategoriesPresenterOutput {
    func addButtonDidPressed(updateCategoriesViewClosure: @escaping VoidAction) {
        delegate?.categoriesAddButtonDidPressed(updateCategoriesViewClosure: updateCategoriesViewClosure)
    }
}
