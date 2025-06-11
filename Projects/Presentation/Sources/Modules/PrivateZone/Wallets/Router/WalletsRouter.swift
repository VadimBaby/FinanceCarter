//
//  WalletsCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 09.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit
import MyCommon

protocol WalletsRouterOutput: AnyObject {
    func walletsAddButtonDidTap()
}

protocol WalletsRouterInput: Router {
    var delegate: WalletsRouterOutput? { get set }
    
    typealias ModuleAssembly = (_ router: WalletsPresenterOutput, _ resolver: Resolver) -> WalletsViewInput & UIViewController
    
    var moduleAssembly: ModuleAssembly? { get set }
    
    func open()
    func update()
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
    
    private var updateWalletsViewClosure: VoidAction?
    
    func open() {
        guard let module = moduleAssembly?(self, resolver) else { fatalError("moduleAssembly is nil in \(self)") }
        navigationController.pushViewController(module, animated: true)
    }
    
    func update() {
        updateWalletsViewClosure?()
    }
}

// MARK: - WalletsPresenterOutput

extension WalletsRouter: WalletsPresenterOutput {
    func addButtonDidTap() {
        delegate?.walletsAddButtonDidTap()
    }
    
    func viewDidLoad(updateWalletsViewClosure: @escaping VoidAction) {
        self.updateWalletsViewClosure = updateWalletsViewClosure
    }
}
