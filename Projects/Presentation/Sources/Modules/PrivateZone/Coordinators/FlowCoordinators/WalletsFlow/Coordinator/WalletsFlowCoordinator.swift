//
//  WalletsFlowCoordinator.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 10.04.2025.
//  Copyright © 2025 Vadim Martynenko. All rights reserved.
//

import UIKit

protocol WalletsFlowCoordinatorOutput: AnyObject {
    func walletsFlowCoordinatorDidStart(with viewController: UIViewController)
}

protocol WalletsFlowCoordinatorInput: NavigationCoordinator {
    var delegate: WalletsFlowCoordinatorOutput? { get set }
}

final class WalletsFlowCoordinator: WalletsFlowCoordinatorInput {
    weak var delegate: WalletsFlowCoordinatorOutput?
    
    private let resolver: Resolver
    
    let navigationController: UINavigationController
    
    typealias WalletsRouterAssembly = (_ navigationController: UINavigationController, _ resolver: Resolver) -> WalletsRouterInput
    
    private let walletsRouterAssembly: WalletsRouterAssembly
    
    private var walletsRouter: WalletsRouterInput?
    
    init(
        navigationController: UINavigationController = UINavigationController(),
        resolver: Resolver,
        walletsRouterAssembly: @escaping WalletsRouterAssembly
    ) {
        self.walletsRouterAssembly = walletsRouterAssembly
        
        self.resolver = resolver
        
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        
        print("\(Self.self) init")
    }
    
    deinit {
        print("\(Self.self) deinit")
    }
    
    func start() {
        walletsRouter = walletsRouterAssembly(navigationController, resolver)
        walletsRouter?.delegate = self
        walletsRouter?.open()
        delegate?.walletsFlowCoordinatorDidStart(with: navigationController)
    }
}

extension WalletsFlowCoordinator: WalletsRouterOutput {
    
}
