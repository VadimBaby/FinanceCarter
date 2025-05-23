//
//  CreateCategoryRouter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 19.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol CreateCategoryRouterOutput: AnyObject {
    func createCategoryCloseButtonDidPressed()
    func categoryDidAdded()
}

protocol CreateCategoryRouterInput: Router {
    var delegate: CreateCategoryRouterOutput? { get set }
    
    typealias ModuleAssembly = (_ router: CreateCategoryPresenterOutput, _ resolver: Resolver) -> CreateCategoryViewInput & UIViewController
    
    var moduleAssembly: ModuleAssembly? { get set }
    
    func open()
    func close() 
}

final class CreateCategoryRouter: CreateCategoryRouterInput {
    weak var delegate: CreateCategoryRouterOutput?
    
    var navigationController: UINavigationController
    
    private let resolver: Resolver
    
    var moduleAssembly: ModuleAssembly?
    
    private weak var presentedModule: UIViewController?
    
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
        let moduleCoveredInNavigationVC = UINavigationController(rootViewController: module)
        self.presentedModule = moduleCoveredInNavigationVC
        
        navigationController.present(moduleCoveredInNavigationVC, animated: true)
    }
    
    func close() {
        presentedModule?.dismiss(animated: true)
    }
}

// MARK: - CreateCategoryPresenterOutput

extension CreateCategoryRouter: CreateCategoryPresenterOutput {
    func closeButtonDidPressed() {
        delegate?.createCategoryCloseButtonDidPressed()
    }
    
    func categoryDidAdded() {
        delegate?.categoryDidAdded()
    }
}
