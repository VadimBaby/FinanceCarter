//
//  TransactionsCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import Common

protocol TransactionsRouterOutput: AnyObject {
    func transactionsAddButtonDidTap(updateTransactionsViewClosure: @escaping VoidAction)
}

protocol TransactionsRouterInput: Router {
    var delegate: TransactionsRouterOutput? { get set }
    
    typealias ModuleAssembly = (_ router: TransactionsPresenterOutput, _ resolver: Resolver) -> TransactionsViewInput & UIViewController
    
    var moduleAssembly: ModuleAssembly? { get set }
    
    func open()
}

final class TransactionsRouter: TransactionsRouterInput {
    weak var delegate: TransactionsRouterOutput?
    
    private let resolver: Resolver
    
    let navigationController: UINavigationController
    
    var moduleAssembly: ModuleAssembly?
    
    init(
        navigationController: UINavigationController,
        resolver: Resolver
    ) {
        self.resolver = resolver
        
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func open() {
        guard let module = moduleAssembly?(self, resolver) else { fatalError("moduleAssembly is nil in \(self)") }
        navigationController.pushViewController(module, animated: true)
    }
}

extension TransactionsRouter: TransactionsPresenterOutput {
    func addButtonDidTap(updateTransactionsViewClosure: @escaping VoidAction) {
        delegate?.transactionsAddButtonDidTap(updateTransactionsViewClosure: updateTransactionsViewClosure)
    }
}
