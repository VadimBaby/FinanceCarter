//
//  CreateWalletRouter.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 25.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol CreateWalletRouterOutput: AnyObject {
    
}

protocol CreateWalletRouterInput: Router {
    var delegate: CreateWalletRouterOutput? { get set }
    
    typealias ModuleAssembly = (_ router: CreateWalletPresenterOutput, _ resolver: Resolver) -> CreateWalletViewInput & UIViewController
    
    var moduleAssembly: ModuleAssembly? { get set }
    
    func open()
}

final class CreateWalletRouter: CreateWalletRouterInput {
    weak var delegate: CreateWalletRouterOutput?
    
    private let resolver: Resolver
    
    let navigationController: UINavigationController
    
    typealias CategoriesAssembly = (_ coordinator: CreateWalletPresenterOutput, _ resolver: Resolver) -> CreateWalletViewInput & UIViewController
    
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
        navigationController.present(module, animated: true)
    }
}

extension CreateWalletRouter: CreateWalletPresenterOutput {
    
}
