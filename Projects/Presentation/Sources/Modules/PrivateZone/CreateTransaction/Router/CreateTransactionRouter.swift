//
//  CreateTransactionRouter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 29.05.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol CreateTransactionRouterOutput: AnyObject {
    func createTransactionCloseButtonDidPressed()
    func transactionDidAdded()
}

protocol CreateTransactionRouterInput: Router {
    var delegate: CreateTransactionRouterOutput? { get set }
    
    typealias ModuleAssembly = (_ router: CreateTransactionPresenterOutput, _ resolver: Resolver) -> CreateTransactionViewInput & UIViewController
    
    var moduleAssembly: ModuleAssembly? { get set }
    
    func open()
    func close()
}

final class CreateTransactionRouter: CreateTransactionRouterInput {
    weak var delegate: CreateTransactionRouterOutput?
    
    private let resolver: Resolver
    
    let navigationController: UINavigationController
    
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

extension CreateTransactionRouter: CreateTransactionPresenterOutput {
    func closeButtonDidPressed() {
        delegate?.createTransactionCloseButtonDidPressed()
    }
    
    func transactionDidAdded() {
        delegate?.transactionDidAdded()
    }
}
