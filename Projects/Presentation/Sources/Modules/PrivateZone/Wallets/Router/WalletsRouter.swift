//
//  WalletsCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol WalletsRouterOutput: AnyObject {
    func walletsAddButtonDidTap()
}

protocol WalletsRouterInput: Router {
    var delegate: WalletsRouterOutput? { get set }
    
    typealias ModuleAssembly = (_ router: WalletsPresenterOutput, _ resolver: Resolver) -> WalletsViewInput & UIViewController
    
    var moduleAssembly: ModuleAssembly? { get set }
    
    func open()
}

final class WalletsRouter: WalletsRouterInput {
    weak var delegate: WalletsRouterOutput?
    
    private let resolver: Resolver
    
    let navigationController: UINavigationController
    
    var moduleAssembly: ModuleAssembly?
    
    init(
        navigationController: UINavigationController,
        resolver: Resolver
    ) {
        self.resolver = resolver
        self.navigationController = navigationController
        
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

// MARK: - WalletsPresenterOutput

extension WalletsRouter: WalletsPresenterOutput {
    func addButtonDidTap() {
        delegate?.walletsAddButtonDidTap()
    }
}
